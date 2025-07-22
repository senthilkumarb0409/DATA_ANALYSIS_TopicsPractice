import streamlit as st
import pandas as pd
import numpy as np
import sweetviz
import os
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
import plotly.graph_objects as go
import plotly.figure_factory as ff
from plotly.subplots import make_subplots
from io import StringIO, BytesIO
import re
from datetime import datetime
import warnings
warnings.filterwarnings('ignore')

# Set style for matplotlib
plt.style.use('default')
sns.set_palette("husl")

# Helper functions for suggestions
def get_suggestion_reasoning(col):
    """Provide reasoning for fill suggestions"""
    if pd.api.types.is_numeric_dtype(col):
        non_null = col.dropna()
        if len(non_null) > 1:
            try:
                skewness = non_null.skew()
                if abs(skewness) > 1:
                    return f"Highly skewed data (skewness: {skewness:.2f}), median is more robust"
                else:
                    return f"Normally distributed data (skewness: {skewness:.2f}), mean is appropriate"
            except:
                return "Numeric data, median recommended as fallback"
    else:
        try:
            uniqueness = col.nunique() / len(col.dropna()) if len(col.dropna()) > 0 else 0
            if uniqueness > 0.9:
                return "High uniqueness suggests ID-like column, dropping rows preserves data integrity"
            else:
                return "Categorical data, mode (most frequent value) is most appropriate"
        except:
            return "Categorical data, mode recommended"
    return "Standard recommendation"

def get_suggestion_index(suggestion):
    """Get index for selectbox based on suggestion"""
    options = ['Do Nothing', 'mean', 'median', 'mode', 'Custom Value', 'Drop Rows with Missing', 'Drop Column']
    try:
        return options.index(suggestion)
    except ValueError:
        return 0

# Enhanced unmatched value detection - comprehensive list of common unmatched values
COMMON_UNMATCHED_VALUES = [
    # Standard nulls and empty
    'unknown', 'n/a', '', 'na', 'none', 'null', 'nan', 'nil', 'undefined',
    
    # Case variations
    'Unknown', 'UNKNOWN', 'N/A', 'NA', 'None', 'NONE', 'Null', 'NULL', 
    'NaN', 'NAN', 'Nil', 'NIL', 'Undefined', 'UNDEFINED',
    
    # With spacing
    ' ', '  ', '   ', 'n / a', 'n /a', 'n/ a', 'not available', 'not applicable',
    'NOT AVAILABLE', 'NOT APPLICABLE', 'Not Available', 'Not Applicable',
    
    # Symbols and placeholders
    '-', '--', '---', '_', '__', '___', '?', '??', '???', 
    '#N/A', '#NULL', '#REF!', '#DIV/0!', '#VALUE!', '#NAME?',
    
    # Common data entry errors
    'error', 'Error', 'ERROR', 'err', 'Err', 'ERR',
    'missing', 'Missing', 'MISSING', 'miss', 'Miss', 'MISS',
    'blank', 'Blank', 'BLANK', 'empty', 'Empty', 'EMPTY',
    'no data', 'No Data', 'NO DATA', 'nodata', 'NoData', 'NODATA',
    'not specified', 'Not Specified', 'NOT SPECIFIED', 'unspecified',
    'Unspecified', 'UNSPECIFIED', 'not given', 'Not Given', 'NOT GIVEN',
    
    # Common typos and variations
    'unkown', 'Unkown', 'UNKOWN', 'unknow', 'Unknow', 'UNKNOW',
    'n.a', 'N.A', 'n.a.', 'N.A.', 'n\\a', 'N\\A',
    
    # Database/system specific
    'NULL_VALUE', 'null_value', 'MISSING_VALUE', 'missing_value',
    'NO_VALUE', 'no_value', 'UNDEFINED_VALUE', 'undefined_value',
    
    # Numeric representations of missing
    '-999', '-9999', '999', '9999', '0', '00', '000'
]

# Helper: Enhanced clean column function with comprehensive unmatched value detection
def clean_column(df, col):
    """Enhanced cleaning with comprehensive unmatched value detection"""
    # Convert to string first to handle mixed types
    original_dtype = df[col].dtype
    df[col] = df[col].astype(str)
    
    # Replace comprehensive list of unmatched values
    df[col] = df[col].replace(COMMON_UNMATCHED_VALUES, np.nan, regex=False)
    
    # Also handle regex patterns for common variations
    regex_patterns = [
        r'^\s*$',  # Only whitespace
        r'^n\s*/\s*a$',  # n/a with various spacing
        r'^not?\s+available?$',  # not available variations
        r'^not?\s+applicable?$',  # not applicable variations
        r'^-+$',  # Only dashes
        r'^_+$',  # Only underscores
        r'^\?+$',  # Only question marks
    ]
    
    for pattern in regex_patterns:
        df[col] = df[col].replace(regex=True, to_replace=pattern, value=np.nan)
    
    # Try to convert back to numeric if originally numeric or if it makes sense
    if original_dtype in [np.float64, np.int64] or pd.api.types.is_numeric_dtype(df[col].replace(np.nan, '0')):
        try:
            df[col] = pd.to_numeric(df[col], errors='coerce')
        except:
            pass
    
    return df[col]

# Enhanced fill suggestion logic
def suggest_fill(col, df_sample=None):
    """Smart fill suggestion based on column characteristics"""
    
    # Get basic info about the column
    non_null_data = col.dropna()
    data_type = col.dtype
    unique_count = col.nunique()
    total_count = len(col)
    non_null_count = len(non_null_data)
    
    # If mostly missing, suggest dropping
    if non_null_count / total_count < 0.3:
        return 'Drop Column'
    
    # Numeric columns
    if pd.api.types.is_numeric_dtype(data_type):
        # Check for skewness to decide between mean and median
        if non_null_count > 1:
            try:
                skewness = non_null_data.skew()
                # If highly skewed, prefer median
                if abs(skewness) > 1:
                    return 'median'
                else:
                    return 'mean'
            except:
                return 'median'
        else:
            return 'median'
    
    # Categorical/Object columns
    else:
        # Convert to string for analysis
        str_data = non_null_data.astype(str).str.lower().str.strip()
        
        # Check if it's binary/boolean-like
        unique_vals = set(str_data.unique())
        binary_patterns = [
            {'yes', 'no'}, {'y', 'n'}, {'true', 'false'}, {'1', '0'},
            {'male', 'female'}, {'m', 'f'}, {'active', 'inactive'},
            {'on', 'off'}, {'enabled', 'disabled'}, {'pass', 'fail'}
        ]
        
        for pattern in binary_patterns:
            if unique_vals.issubset(pattern) or pattern.issubset(unique_vals):
                return 'mode'
        
        # Check for ID-like columns (high uniqueness)
        uniqueness_ratio = unique_count / non_null_count if non_null_count > 0 else 0
        if uniqueness_ratio > 0.9:
            return 'Drop Rows with Missing'
        
        # Check for categories with clear dominant value
        if non_null_count > 0:
            mode_frequency = str_data.value_counts().iloc[0] / non_null_count
            if mode_frequency > 0.5:  # If mode represents >50% of data
                return 'mode'
        
        # Default for categorical
        return 'mode'

# Enhanced unmatched value detection function
def detect_unmatched_values(df):
    """Detect various forms of unmatched values in the dataset"""
    unmatched_stats = {}
    
    for col in df.columns:
        col_data = df[col].astype(str) if df[col].dtype != 'object' else df[col]
        
        # Count standard nulls
        null_count = df[col].isnull().sum()
        
        # Count empty strings and whitespace
        empty_count = (col_data == '').sum() + (col_data.str.strip() == '').sum()
        
        # Count common unmatched values (case insensitive)
        unmatched_count = 0
        for unmatched_val in COMMON_UNMATCHED_VALUES:
            if isinstance(unmatched_val, str):
                unmatched_count += col_data.str.lower().eq(unmatched_val.lower()).sum()
            else:
                unmatched_count += (col_data == unmatched_val).sum()
        
        # Store results
        unmatched_stats[col] = {
            'nulls': null_count,
            'empty': empty_count,
            'unmatched': unmatched_count,
            'total_issues': null_count + empty_count + unmatched_count
        }
    
    return unmatched_stats

# ============================================================================
# DATA VISUALIZATION FUNCTIONS
# ============================================================================

def analyze_data_for_visualization(df):
    """Analyze dataset to suggest appropriate visualizations"""
    analysis = {
        'numerical_cols': [],
        'categorical_cols': [],
        'binary_cols': [],
        'datetime_cols': [],
        'high_cardinality_cols': [],
        'suggested_charts': {}
    }
    
    for col in df.columns:
        if pd.api.types.is_numeric_dtype(df[col]):
            analysis['numerical_cols'].append(col)
        elif pd.api.types.is_datetime64_any_dtype(df[col]):
            analysis['datetime_cols'].append(col)
        else:
            unique_count = df[col].nunique()
            if unique_count == 2:
                analysis['binary_cols'].append(col)
            elif unique_count > 20:
                analysis['high_cardinality_cols'].append(col)
            else:
                analysis['categorical_cols'].append(col)
    
    # Suggest charts based on data types
    suggestions = []
    
    if len(analysis['numerical_cols']) >= 1:
        suggestions.extend([
            "📊 Histogram - Distribution of numerical columns",
            "📈 Box Plot - Outliers and quartiles",
            "🎯 Violin Plot - Distribution density"
        ])
    
    if len(analysis['numerical_cols']) >= 2:
        suggestions.extend([
            "🔗 Scatter Plot - Relationship between two numerical variables",
            "🌡️ Heatmap - Correlation matrix"
        ])
    
    if len(analysis['categorical_cols']) >= 1:
        suggestions.extend([
            "🥧 Pie Chart - Proportion of categories",
            "📊 Bar Chart - Count/frequency of categories"
        ])
    
    if len(analysis['numerical_cols']) >= 1 and len(analysis['categorical_cols']) >= 1:
        suggestions.extend([
            "📊 Grouped Bar Chart - Numerical values by categories",
            "📈 Box Plot by Category - Distribution across categories"
        ])
    
    if len(analysis['datetime_cols']) >= 1:
        suggestions.append("📈 Time Series Plot - Trends over time")
    
    analysis['chart_suggestions'] = suggestions
    return analysis

def create_histogram(df, column, bins=30):
    """Create interactive histogram"""
    fig = px.histogram(df, x=column, nbins=bins, 
                      title=f'Distribution of {column}',
                      color_discrete_sequence=['#1f77b4'])
    fig.update_layout(
        xaxis_title=column,
        yaxis_title='Frequency',
        showlegend=False
    )
    return fig

def create_box_plot(df, column, category_col=None):
    """Create interactive box plot"""
    if category_col:
        fig = px.box(df, y=column, x=category_col,
                    title=f'Box Plot of {column} by {category_col}')
    else:
        fig = px.box(df, y=column, title=f'Box Plot of {column}')
    
    fig.update_layout(
        yaxis_title=column,
        showlegend=False
    )
    return fig

def create_violin_plot(df, column, category_col=None):
    """Create interactive violin plot"""
    if category_col:
        fig = px.violin(df, y=column, x=category_col,
                       title=f'Violin Plot of {column} by {category_col}')
    else:
        fig = px.violin(df, y=column, title=f'Violin Plot of {column}')
    
    return fig

def create_scatter_plot(df, x_col, y_col, color_col=None, size_col=None):
    """Create interactive scatter plot"""
    fig = px.scatter(df, x=x_col, y=y_col, color=color_col, size=size_col,
                    title=f'Scatter Plot: {x_col} vs {y_col}',
                    hover_data=df.columns)
    return fig

def create_correlation_heatmap(df):
    """Create correlation heatmap"""
    numerical_cols = df.select_dtypes(include=[np.number]).columns
    if len(numerical_cols) > 1:
        corr_matrix = df[numerical_cols].corr()
        fig = px.imshow(corr_matrix, 
                       title='Correlation Heatmap',
                       color_continuous_scale='RdBu',
                       aspect='auto')
        fig.update_layout(
            width=600,
            height=600
        )
        return fig
    return None

def create_pie_chart(df, column):
    """Create interactive pie chart"""
    value_counts = df[column].value_counts().head(10)  # Top 10 categories
    fig = px.pie(values=value_counts.values, names=value_counts.index,
                title=f'Distribution of {column}')
    return fig

def create_bar_chart(df, column, orientation='v'):
    """Create interactive bar chart"""
    value_counts = df[column].value_counts().head(15)  # Top 15 categories
    
    if orientation == 'h':
        fig = px.bar(x=value_counts.values, y=value_counts.index,
                    orientation='h',
                    title=f'Count of {column}')
        fig.update_layout(yaxis={'categoryorder':'total ascending'})
    else:
        fig = px.bar(x=value_counts.index, y=value_counts.values,
                    title=f'Count of {column}')
        fig.update_xaxes(tickangle=45)
    
    return fig

def create_grouped_bar_chart(df, category_col, value_col, agg_func='mean'):
    """Create grouped bar chart"""
    if agg_func == 'mean':
        grouped_data = df.groupby(category_col)[value_col].mean().reset_index()
        title = f'Average {value_col} by {category_col}'
    elif agg_func == 'sum':
        grouped_data = df.groupby(category_col)[value_col].sum().reset_index()
        title = f'Sum of {value_col} by {category_col}'
    else:
        grouped_data = df.groupby(category_col)[value_col].count().reset_index()
        title = f'Count of {value_col} by {category_col}'
    
    fig = px.bar(grouped_data, x=category_col, y=value_col, title=title)
    fig.update_xaxes(tickangle=45)
    return fig

def create_time_series_plot(df, date_col, value_col):
    """Create time series plot"""
    df_sorted = df.sort_values(date_col)
    fig = px.line(df_sorted, x=date_col, y=value_col,
                 title=f'{value_col} over time')
    return fig

def create_pair_plot(df, columns):
    """Create pair plot for multiple numerical columns"""
    if len(columns) > 1:
        fig = px.scatter_matrix(df[columns], title="Pair Plot of Selected Columns")
        fig.update_traces(diagonal_visible=False)
        return fig
    return None

# ============================================================================
# MAIN APP
# ============================================================================

# App layout
st.set_page_config(layout="wide")
st.title("🔧 Enhanced Automated Data Cleaning & Visualization App")

uploaded_file = st.file_uploader("Upload CSV File", type=["csv"])
if uploaded_file is None:
    st.info("👈 Please upload a CSV file to start cleaning and visualizing.")

if uploaded_file is not None:
    try:
        df = pd.read_csv(uploaded_file)
    except:
        uploaded_file.seek(0)
        df = pd.read_csv(uploaded_file, delimiter=';')

    # Keep a copy of the original data for preview
    original_df = df.copy()

    st.subheader("📋 Original Dataset Preview")
    preview_rows = 15
    if len(df) <= preview_rows:
        st.dataframe(df)
    else:
        st.dataframe(df.head(preview_rows))
        if st.button("Preview Full Data"):
            st.markdown(
                f'<a href="data:text/csv;charset=utf-8,{df.to_csv(index=False).replace("\n", "%0A").replace(",", "%2C")}" target="_blank">Open Full Data in New Tab</a>',
                unsafe_allow_html=True
            )

    # Enhanced unmatched value cleaning
    st.subheader("🧹 Enhanced Data Cleaning")
    
    # Apply comprehensive cleaning to each column
    for col in df.columns:
        df[col] = clean_column(df, col)

    # Standardize categorical labels
    for col in df.select_dtypes(include='object').columns:
        before = df[col].copy()
        df[col] = df[col].str.strip().str.lower()
        if not before.equals(df[col]):
            st.write(f"Standardized labels in '{col}' (stripped and lowercased)")

    # Cleaning log
    change_log = []

    # --- Detect and store column types and subtypes ---
    def update_column_types(df):
        numerical_cols = df.select_dtypes(include=[np.number]).columns.tolist()
        categorical_cols = df.select_dtypes(include=['object', 'category', 'bool']).columns.tolist()
        int_cols = df.select_dtypes(include=['int', 'int32', 'int64']).columns.tolist()
        float_cols = df.select_dtypes(include=['float', 'float32', 'float64']).columns.tolist()
        str_cols = df.select_dtypes(include=['object']).columns.tolist()
        bool_cols = df.select_dtypes(include=['bool']).columns.tolist()
        category_cols = df.select_dtypes(include=['category']).columns.tolist()
        return numerical_cols, categorical_cols, int_cols, float_cols, str_cols, bool_cols, category_cols

    numerical_cols, categorical_cols, int_cols, float_cols, str_cols, bool_cols, category_cols = update_column_types(df)

    # Enhanced Data Structure Table
    st.markdown("### 🏗️ Enhanced Data Structure")
    structure_df = pd.DataFrame({
        "Column": df.columns,
        "Type": [df[col].dtype for col in df.columns],
        "Unique Values": [df[col].nunique() for col in df.columns],
        "Sample Values": [", ".join(map(str, df[col].dropna().unique()[:3])) for col in df.columns],
        "Uniqueness %": [round(df[col].nunique() / len(df) * 100, 1) for col in df.columns]
    })
    st.dataframe(structure_df)

    # Enhanced Data Issues Detection
    st.markdown("### 🚩 Enhanced Data Issues Detection")
    unmatched_stats = detect_unmatched_values(df)
    
    issues_df = pd.DataFrame({
        "Column": df.columns,
        "Nulls": [unmatched_stats[col]['nulls'] for col in df.columns],
        "Empty/Whitespace": [unmatched_stats[col]['empty'] for col in df.columns],
        "Unmatched Values": [unmatched_stats[col]['unmatched'] for col in df.columns],
        "Total Issues": [unmatched_stats[col]['total_issues'] for col in df.columns],
        "Issue %": [round(unmatched_stats[col]['total_issues'] / len(df) * 100, 1) for col in df.columns]
    })
    st.dataframe(issues_df)

    # Highlight columns with >30% missing/unmatched values
    high_missing = issues_df[issues_df['Issue %'] > 30]['Column'].tolist()
    if high_missing:
        st.warning(f"⚠️ Columns with more than 30% missing/unmatched values: {', '.join(high_missing)}")

        st.markdown("#### What would you like to do with these columns?")
        for col in high_missing:
            action = st.selectbox(
                f"Action for '{col}':",
                options=["Do Nothing", "Drop Column", "Fill with Mean/Mode", "Fill with Custom Value"],
                key=f"high_missing_{col}"
            )
            if action == "Drop Column":
                df.drop(columns=[col], inplace=True)
                change_log.append(f"Dropped column '{col}' due to high missing/unmatched values")
            elif action == "Fill with Mean/Mode":
                if pd.api.types.is_numeric_dtype(df[col]):
                    df[col].fillna(df[col].mean(), inplace=True)
                    change_log.append(f"Filled missing in '{col}' with mean")
                else:
                    df[col].fillna(df[col].mode().iloc[0], inplace=True)
                    change_log.append(f"Filled missing in '{col}' with mode")
            elif action == "Fill with Custom Value":
                custom_value = st.text_input(f"Enter custom fill value for '{col}':", key=f"custom_{col}")
                if custom_value != "":
                    df[col].fillna(custom_value, inplace=True)
                    change_log.append(f"Filled missing in '{col}' with custom value '{custom_value}'")

    # Update column types after dropping/filling
    numerical_cols, categorical_cols, int_cols, float_cols, str_cols, bool_cols, category_cols = update_column_types(df)

    # Data Summary
    st.subheader("📊 Enhanced Data Summary")
    st.markdown("### 🔹 Column Data Types")
    st.dataframe(df.dtypes.reset_index().rename(columns={0: 'DataType', 'index': 'Column'}))

    st.markdown("### 🔹 Missing Value Summary")
    missing_info = df.isnull().sum()
    missing_info = missing_info[missing_info > 0].reset_index()
    missing_info.columns = ['Column', 'MissingCount']
    st.dataframe(missing_info)

    # --- 1. Collect all user cleaning choices with ENHANCED SUGGESTIONS ---

    # Enhanced Fill missing/unmatched values with smart suggestions
    fill_actions = {}
    custom_values = {}
    if not missing_info.empty:
        st.markdown("### 🧠 Enhanced Smart Suggestions for Filling Missing/Unmatched Values")
        for col in missing_info['Column']:
            smart_suggestion = suggest_fill(df[col], df)
            
            # Show reasoning for the suggestion
            col_info = f"**{col}**: "
            if pd.api.types.is_numeric_dtype(df[col]):
                skewness = df[col].dropna().skew() if len(df[col].dropna()) > 1 else 0
                col_info += f"Numeric column (skewness: {skewness:.2f})"
            else:
                uniqueness = df[col].nunique() / len(df[col].dropna()) if len(df[col].dropna()) > 0 else 0
                col_info += f"Categorical column (uniqueness: {uniqueness:.2f})"
            
            st.markdown(col_info)
            st.info(f"💡 Smart suggestion: **{smart_suggestion}** - {get_suggestion_reasoning(df[col])}")
            
            fill_actions[col] = st.selectbox(
                f"How would you like to handle missing/unmatched in '{col}'?",
                options=['Do Nothing', 'mean', 'median', 'mode', 'Custom Value', 'Drop Rows with Missing', 'Drop Column'],
                index=get_suggestion_index(smart_suggestion),
                key=f"fill_{col}"
            )
            if fill_actions[col] == 'Custom Value':
                custom_values[col] = st.text_input(f"Enter custom fill value for '{col}':", key=f"custom_fill_{col}")

    # Outlier removal
    outlier_cols = st.multiselect("Select columns for outlier removal (IQR method):", options=numerical_cols, key="outlier_cols")

    # Data type correction
    type_changes = {}
    for col in df.columns:
        current_type = str(df[col].dtype)
        type_changes[col] = st.selectbox(
            f"Change type for '{col}' (current: {current_type}):",
            options=['No Change', 'int', 'float', 'str', 'category'],
            key=f"type_{col}"
        )

    # Drop columns
    drop_cols = st.multiselect("Select columns to drop:", options=df.columns.tolist(), key="drop_cols")

    # Remove duplicates
    remove_duplicates = st.checkbox("Remove duplicate rows", key="remove_dupes")

    # --- 2. Final Clean Button ---
    if st.button("🚀 Clean Data with Enhanced Logic"):
        cleaned_df = df.copy()
        # Fill missing/unmatched values
        for col in missing_info['Column']:
            action = fill_actions.get(col, 'Do Nothing')
            if action == 'mean' and pd.api.types.is_numeric_dtype(cleaned_df[col]):
                cleaned_df[col].fillna(cleaned_df[col].mean(), inplace=True)
                change_log.append(f"Filled missing/unmatched values in '{col}' using mean")
            elif action == 'median' and pd.api.types.is_numeric_dtype(cleaned_df[col]):
                cleaned_df[col].fillna(cleaned_df[col].median(), inplace=True)
                change_log.append(f"Filled missing/unmatched values in '{col}' using median")
            elif action == 'mode':
                mode_val = cleaned_df[col].mode()
                if len(mode_val) > 0:
                    cleaned_df[col].fillna(mode_val.iloc[0], inplace=True)
                    change_log.append(f"Filled missing/unmatched values in '{col}' using mode")
            elif action == 'Custom Value' and custom_values.get(col) is not None:
                cleaned_df[col].fillna(custom_values[col], inplace=True)
                change_log.append(f"Filled missing/unmatched values in '{col}' with custom value '{custom_values[col]}'")
            elif action == 'Drop Rows with Missing':
                before = cleaned_df.shape[0]
                cleaned_df.dropna(subset=[col], inplace=True)
                after = cleaned_df.shape[0]
                change_log.append(f"Dropped {before - after} rows with missing/unmatched values in '{col}'")
            elif action == 'Drop Column':
                cleaned_df.drop(columns=[col], inplace=True)
                change_log.append(f"Dropped column '{col}' due to missing/unmatched values")
                
        # Outlier removal
        for col in outlier_cols:
            if col in cleaned_df.columns:
                Q1 = cleaned_df[col].quantile(0.25)
                Q3 = cleaned_df[col].quantile(0.75)
                IQR = Q3 - Q1
                before = cleaned_df.shape[0]
                cleaned_df = cleaned_df[(cleaned_df[col] >= Q1 - 1.5 * IQR) & (cleaned_df[col] <= Q3 + 1.5 * IQR)]
                after = cleaned_df.shape[0]
                change_log.append(f"Removed {before - after} outliers from '{col}' using IQR method")
                
        # Data type correction
        for col in cleaned_df.columns:
            new_type = type_changes.get(col, 'No Change')
            try:
                if new_type == 'int':
                    cleaned_df[col] = pd.to_numeric(cleaned_df[col], errors='coerce').round().astype('Int64')
                elif new_type == 'float':
                    cleaned_df[col] = pd.to_numeric(cleaned_df[col], errors='coerce').astype(float)
                elif new_type == 'str':
                    cleaned_df[col] = cleaned_df[col].astype(str)
                elif new_type == 'category':
                    cleaned_df[col] = cleaned_df[col].astype('category')
                if new_type != 'No Change':
                    change_log.append(f"Changed type of '{col}' to {new_type}")
            except Exception as e:
                st.error(f"Could not convert '{col}' to {new_type}: {e}")
                
        # Drop columns
        if drop_cols:
            cleaned_df.drop(columns=drop_cols, inplace=True)
            change_log.append(f"Dropped columns: {', '.join(drop_cols)}")
            
        # Remove duplicates
        if remove_duplicates:
            before = cleaned_df.shape[0]
            cleaned_df.drop_duplicates(inplace=True)
            after = cleaned_df.shape[0]
            change_log.append(f"Removed {before - after} duplicate rows")
            st.success(f"Removed {before - after} duplicate rows.")
            
        # Ensure columns like 'income' are integer if appropriate
        int_keywords = ['age', 'income', 'count', 'number', 'qty', 'quantity', 'id', 'year']
        for col in cleaned_df.columns:
            if any(kw in col.lower() for kw in int_keywords) and pd.api.types.is_numeric_dtype(cleaned_df[col]):
                try:
                    cleaned_df[col] = cleaned_df[col].round().astype('Int64')
                except:
                    pass

        # Save to session state
        st.session_state.cleaned_df = cleaned_df
        st.success("✅ Data cleaning completed with enhanced logic!")

    # Always use the cleaned data for preview and download if file is uploaded
    df = st.session_state.get('cleaned_df', df)

    # ============================================================================
    # DATA VISUALIZATION SECTION
    # ============================================================================
    
    st.header("📈 Interactive Data Visualization")
    
    # Analyze data for visualization suggestions
    viz_analysis = analyze_data_for_visualization(df)
    
    # Display data analysis summary
    st.subheader("🔍 Data Analysis Summary")
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        st.metric("Numerical Columns", len(viz_analysis['numerical_cols']))
        if viz_analysis['numerical_cols']:
            st.write("📊", ", ".join(viz_analysis['numerical_cols'][:3]))
            if len(viz_analysis['numerical_cols']) > 3:
                st.write(f"... and {len(viz_analysis['numerical_cols']) - 3} more")
    
    with col2:
        st.metric("Categorical Columns", len(viz_analysis['categorical_cols']))
        if viz_analysis['categorical_cols']:
            st.write("🏷️", ", ".join(viz_analysis['categorical_cols'][:3]))
            if len(viz_analysis['categorical_cols']) > 3:
                st.write(f"... and {len(viz_analysis['categorical_cols']) - 3} more")
    
    with col3:
        st.metric("Binary Columns", len(viz_analysis['binary_cols']))
        if viz_analysis['binary_cols']:
            st.write("⚡", ", ".join(viz_analysis['binary_cols'][:3]))
    
    with col4:
        st.metric("High Cardinality Columns", len(viz_analysis['high_cardinality_cols']))
        if viz_analysis['high_cardinality_cols']:
            st.write("🔢", ", ".join(viz_analysis['high_cardinality_cols'][:3]))

    # Chart suggestions
    st.subheader("💡 Recommended Visualizations")
    if viz_analysis['chart_suggestions']:
        st.info("Based on your data types, here are the recommended charts:")
        for suggestion in viz_analysis['chart_suggestions']:
            st.write(f"• {suggestion}")
    else:
        st.warning("No specific chart recommendations available. Try the general visualization options below.")

    # Visualization options
    st.subheader("🎨 Create Visualizations")
    
    # Tabs for different visualization categories
    tab1, tab2, tab3, tab4, tab5 = st.tabs([
        "📊 Univariate Analysis", 
        "🔗 Bivariate Analysis", 
        "🌐 Multivariate Analysis",
        "📈 Time Series",
        "🎯 Custom Charts"
    ])
    
    with tab1:
        st.markdown("### 📊 Univariate Analysis - Single Variable Exploration")
        
        # Numerical columns analysis
        if viz_analysis['numerical_cols']:
            st.markdown("#### Numerical Variables")
            num_col = st.selectbox("Select numerical column:", viz_analysis['numerical_cols'], key="uni_num")
            
            chart_type = st.radio(
                "Choose chart type:",
                ["Histogram", "Box Plot", "Violin Plot"],
                key="uni_num_chart"
            )
            
            if chart_type == "Histogram":
                bins = st.slider("Number of bins:", 10, 100, 30, key="hist_bins")
                fig = create_histogram(df, num_col, bins)
                st.plotly_chart(fig, use_container_width=True)
                st.markdown(f"**Columns used:** {num_col}")
                st.markdown(f"**Chart purpose:** Shows the distribution and frequency of values in {num_col}")
                
            elif chart_type == "Box Plot":
                fig = create_box_plot(df, num_col)
                st.plotly_chart(fig, use_container_width=True)
                st.markdown(f"**Columns used:** {num_col}")
                st.markdown(f"**Chart purpose:** Shows quartiles, median, and outliers in {num_col}")
                
            elif chart_type == "Violin Plot":
                fig = create_violin_plot(df, num_col)
                st.plotly_chart(fig, use_container_width=True)
                st.markdown(f"**Columns used:** {num_col}")
                st.markdown(f"**Chart purpose:** Shows distribution density and quartiles of {num_col}")
        
        # Categorical columns analysis
        if viz_analysis['categorical_cols'] or viz_analysis['binary_cols']:
            st.markdown("#### Categorical Variables")
            cat_cols = viz_analysis['categorical_cols'] + viz_analysis['binary_cols']
            cat_col = st.selectbox("Select categorical column:", cat_cols, key="uni_cat")
            
            chart_type = st.radio(
                "Choose chart type:",
                ["Bar Chart", "Pie Chart"],
                key="uni_cat_chart"
            )
            
            if chart_type == "Bar Chart":
                orientation = st.radio("Orientation:", ["Vertical", "Horizontal"], key="bar_orient")
                fig = create_bar_chart(df, cat_col, 'h' if orientation == "Horizontal" else 'v')
                st.plotly_chart(fig, use_container_width=True)
                st.markdown(f"**Columns used:** {cat_col}")
                st.markdown(f"**Chart purpose:** Shows frequency/count of each category in {cat_col}")
                
            elif chart_type == "Pie Chart":
                fig = create_pie_chart(df, cat_col)
                st.plotly_chart(fig, use_container_width=True)
                st.markdown(f"**Columns used:** {cat_col}")
                st.markdown(f"**Chart purpose:** Shows proportion/percentage of each category in {cat_col}")

    with tab2:
        st.markdown("### 🔗 Bivariate Analysis - Two Variable Relationships")
        
        # Numerical vs Numerical
        if len(viz_analysis['numerical_cols']) >= 2:
            st.markdown("#### Numerical vs Numerical")
            num_col1 = st.selectbox("Select X-axis (numerical):", viz_analysis['numerical_cols'], key="bi_num_x")
            num_col2 = st.selectbox("Select Y-axis (numerical):", 
                                  [col for col in viz_analysis['numerical_cols'] if col != num_col1], 
                                  key="bi_num_y")
            
            # Optional color and size encoding
            color_options = ["None"] + viz_analysis['categorical_cols'] + viz_analysis['binary_cols']
            size_options = ["None"] + viz_analysis['numerical_cols']
            
            color_col = st.selectbox("Color by (optional):", color_options, key="scatter_color")
            size_col = st.selectbox("Size by (optional):", size_options, key="scatter_size")
            
            color_col = None if color_col == "None" else color_col
            size_col = None if size_col == "None" else size_col
            
            fig = create_scatter_plot(df, num_col1, num_col2, color_col, size_col)
            st.plotly_chart(fig, use_container_width=True)
            
            columns_used = [num_col1, num_col2]
            if color_col: columns_used.append(f"{color_col} (color)")
            if size_col: columns_used.append(f"{size_col} (size)")
            st.markdown(f"**Columns used:** {', '.join(columns_used)}")
            st.markdown(f"**Chart purpose:** Shows relationship/correlation between {num_col1} and {num_col2}")
        
        # Numerical vs Categorical
        if viz_analysis['numerical_cols'] and (viz_analysis['categorical_cols'] or viz_analysis['binary_cols']):
            st.markdown("#### Numerical vs Categorical")
            num_col = st.selectbox("Select numerical column:", viz_analysis['numerical_cols'], key="bi_num_cat_num")
            cat_cols = viz_analysis['categorical_cols'] + viz_analysis['binary_cols']
            cat_col = st.selectbox("Select categorical column:", cat_cols, key="bi_num_cat_cat")
            
            chart_type = st.radio(
                "Choose chart type:",
                ["Box Plot by Category", "Violin Plot by Category", "Grouped Bar Chart"],
                key="bi_num_cat_chart"
            )
            
            if chart_type == "Box Plot by Category":
                fig = create_box_plot(df, num_col, cat_col)
                st.plotly_chart(fig, use_container_width=True)
                st.markdown(f"**Columns used:** {num_col}, {cat_col}")
                st.markdown(f"**Chart purpose:** Shows distribution of {num_col} across different {cat_col} categories")
                
            elif chart_type == "Violin Plot by Category":
                fig = create_violin_plot(df, num_col, cat_col)
                st.plotly_chart(fig, use_container_width=True)
                st.markdown(f"**Columns used:** {num_col}, {cat_col}")
                st.markdown(f"**Chart purpose:** Shows density distribution of {num_col} across {cat_col} categories")
                
            elif chart_type == "Grouped Bar Chart":
                agg_func = st.selectbox("Aggregation function:", ["mean", "sum", "count"], key="agg_func")
                fig = create_grouped_bar_chart(df, cat_col, num_col, agg_func)
                st.plotly_chart(fig, use_container_width=True)
                st.markdown(f"**Columns used:** {num_col}, {cat_col}")
                st.markdown(f"**Chart purpose:** Shows {agg_func} of {num_col} for each {cat_col} category")

    with tab3:
        st.markdown("### 🌐 Multivariate Analysis - Multiple Variable Relationships")
        
        # Correlation Heatmap
        if len(viz_analysis['numerical_cols']) >= 2:
            st.markdown("#### Correlation Heatmap")
            if st.button("Generate Correlation Heatmap", key="corr_heatmap"):
                fig = create_correlation_heatmap(df)
                if fig:
                    st.plotly_chart(fig, use_container_width=True)
                    st.markdown(f"**Columns used:** All numerical columns ({', '.join(viz_analysis['numerical_cols'])})")
                    st.markdown("**Chart purpose:** Shows correlation strength between all numerical variables")
                else:
                    st.warning("Not enough numerical columns for correlation heatmap")
        
        # Pair Plot
        if len(viz_analysis['numerical_cols']) >= 2:
            st.markdown("#### Pair Plot")
            selected_cols = st.multiselect(
                "Select columns for pair plot (2-5 recommended):",
                viz_analysis['numerical_cols'],
                default=viz_analysis['numerical_cols'][:min(4, len(viz_analysis['numerical_cols']))],
                key="pair_plot_cols"
            )
            
            if len(selected_cols) >= 2:
                if st.button("Generate Pair Plot", key="pair_plot"):
                    fig = create_pair_plot(df, selected_cols)
                    if fig:
                        st.plotly_chart(fig, use_container_width=True)
                        st.markdown(f"**Columns used:** {', '.join(selected_cols)}")
                        st.markdown("**Chart purpose:** Shows relationships between all pairs of selected variables")
        
        # 3D Scatter Plot
        if len(viz_analysis['numerical_cols']) >= 3:
            st.markdown("#### 3D Scatter Plot")
            x_col = st.selectbox("X-axis:", viz_analysis['numerical_cols'], key="3d_x")
            y_col = st.selectbox("Y-axis:", 
                               [col for col in viz_analysis['numerical_cols'] if col != x_col], 
                               key="3d_y")
            z_col = st.selectbox("Z-axis:", 
                               [col for col in viz_analysis['numerical_cols'] if col not in [x_col, y_col]], 
                               key="3d_z")
            
            color_options = ["None"] + viz_analysis['categorical_cols'] + viz_analysis['binary_cols']
            color_col = st.selectbox("Color by (optional):", color_options, key="3d_color")
            color_col = None if color_col == "None" else color_col
            
            if st.button("Generate 3D Scatter Plot", key="3d_scatter"):
                fig = px.scatter_3d(df, x=x_col, y=y_col, z=z_col, color=color_col,
                                  title=f'3D Scatter: {x_col} vs {y_col} vs {z_col}')
                st.plotly_chart(fig, use_container_width=True)
                
                columns_used = [x_col, y_col, z_col]
                if color_col: columns_used.append(f"{color_col} (color)")
                st.markdown(f"**Columns used:** {', '.join(columns_used)}")
                st.markdown(f"**Chart purpose:** Shows 3D relationship between {x_col}, {y_col}, and {z_col}")

    with tab4:
        st.markdown("### 📈 Time Series Analysis")
        
        # Check for datetime columns or columns that might be dates
        potential_date_cols = []
        for col in df.columns:
            if pd.api.types.is_datetime64_any_dtype(df[col]):
                potential_date_cols.append(col)
            elif df[col].dtype == 'object':
                # Check if string column might be dates
                sample_vals = df[col].dropna().head(10).astype(str)
                date_like_count = 0
                for val in sample_vals:
                    try:
                        pd.to_datetime(val)
                        date_like_count += 1
                    except:
                        pass
                if date_like_count / len(sample_vals) > 0.5:
                    potential_date_cols.append(col)
        
        if potential_date_cols and viz_analysis['numerical_cols']:
            date_col = st.selectbox("Select date/time column:", potential_date_cols, key="ts_date")
            value_col = st.selectbox("Select value column:", viz_analysis['numerical_cols'], key="ts_value")
            
            # Try to convert date column if it's not already datetime
            if not pd.api.types.is_datetime64_any_dtype(df[date_col]):
                try:
                    df[date_col] = pd.to_datetime(df[date_col])
                    st.success(f"Successfully converted {date_col} to datetime format")
                except:
                    st.error(f"Could not convert {date_col} to datetime format")
                    st.stop()
            
            if st.button("Generate Time Series Plot", key="time_series"):
                fig = create_time_series_plot(df, date_col, value_col)
                st.plotly_chart(fig, use_container_width=True)
                st.markdown(f"**Columns used:** {date_col} (time), {value_col} (values)")
                st.markdown(f"**Chart purpose:** Shows trend of {value_col} over time")
        else:
            st.info("No datetime columns or numerical columns found for time series analysis")

    with tab5:
        st.markdown("### 🎯 Custom Charts")
        
        # Statistical Summary
        st.markdown("#### Statistical Summary")
        if st.button("Generate Statistical Summary", key="stats_summary"):
            # Numerical columns summary
            if viz_analysis['numerical_cols']:
                st.markdown("**Numerical Columns Summary:**")
                numerical_summary = df[viz_analysis['numerical_cols']].describe()
                st.dataframe(numerical_summary)
            
            # Categorical columns summary
            if viz_analysis['categorical_cols']:
                st.markdown("**Categorical Columns Summary:**")
                for col in viz_analysis['categorical_cols'][:5]:  # Show first 5
                    st.markdown(f"**{col}:**")
                    value_counts = df[col].value_counts().head(10)
                    st.write(value_counts.to_dict())
        
        # Distribution Comparison
        if len(viz_analysis['numerical_cols']) >= 2:
            st.markdown("#### Distribution Comparison")
            selected_cols = st.multiselect(
                "Select columns to compare distributions:",
                viz_analysis['numerical_cols'],
                key="dist_compare_cols"
            )
            
            if len(selected_cols) >= 2:
                if st.button("Compare Distributions", key="dist_compare"):
                    fig = make_subplots(
                        rows=1, cols=len(selected_cols),
                        subplot_titles=selected_cols
                    )
                    
                    for i, col in enumerate(selected_cols, 1):
                        fig.add_trace(
                            go.Histogram(x=df[col], name=col),
                            row=1, col=i
                        )
                    
                    fig.update_layout(
                        title_text="Distribution Comparison",
                        showlegend=False
                    )
                    st.plotly_chart(fig, use_container_width=True)
                    st.markdown(f"**Columns used:** {', '.join(selected_cols)}")
                    st.markdown("**Chart purpose:** Compare distributions of multiple numerical variables")
        
        # Custom Aggregation Chart
        if viz_analysis['categorical_cols'] and viz_analysis['numerical_cols']:
            st.markdown("#### Custom Aggregation Chart")
            group_col = st.selectbox("Group by:", viz_analysis['categorical_cols'], key="agg_group")
            agg_col = st.selectbox("Aggregate:", viz_analysis['numerical_cols'], key="agg_col")
            agg_func = st.selectbox("Function:", ["mean", "sum", "count", "median", "std"], key="custom_agg")
            
            if st.button("Generate Aggregation Chart", key="custom_agg_chart"):
                if agg_func == "mean":
                    agg_data = df.groupby(group_col)[agg_col].mean().reset_index()
                elif agg_func == "sum":
                    agg_data = df.groupby(group_col)[agg_col].sum().reset_index()
                elif agg_func == "count":
                    agg_data = df.groupby(group_col)[agg_col].count().reset_index()
                elif agg_func == "median":
                    agg_data = df.groupby(group_col)[agg_col].median().reset_index()
                elif agg_func == "std":
                    agg_data = df.groupby(group_col)[agg_col].std().reset_index()
                
                fig = px.bar(agg_data, x=group_col, y=agg_col,
                           title=f'{agg_func.title()} of {agg_col} by {group_col}')
                fig.update_xaxes(tickangle=45)
                st.plotly_chart(fig, use_container_width=True)
                st.markdown(f"**Columns used:** {group_col} (grouping), {agg_col} (values)")
                st.markdown(f"**Chart purpose:** Shows {agg_func} of {agg_col} for each {group_col} category")

    # Chart Export Options
    st.subheader("💾 Chart Export Options")
    st.info("💡 **Tip:** You can download any chart by hovering over it and clicking the camera icon in the top-right corner of the chart.")
    st.markdown("""
    **Available export formats:**
    - 📸 PNG - High quality images for presentations
    - 📄 PDF - Vector format for documents
    - 🌐 HTML - Interactive charts for web
    - 📊 SVG - Scalable vector graphics
    """)

    # Sweetviz Profiling (optional: add caching for performance)
    @st.cache_data
    def generate_sweetviz_report(df):
        report = sweetviz.analyze(df)
        report_path = "sweetviz_report.html"
        report.show_html(report_path, open_browser=False)
        return report_path

    st.subheader("📊 Sweetviz Automated Profiling Report")
    if st.button("Generate Sweetviz Report"):
        report_path = generate_sweetviz_report(df)
        with open(report_path, 'rb') as f:
            st.download_button("Download Sweetviz Report", f, file_name="Sweetviz_Report.html")

    # Download cleaned data and summary
    st.subheader("📥 Download Results")
    cleaned_csv = df.to_csv(index=False).encode('utf-8')
    st.download_button("⬇ Download Cleaned CSV", cleaned_csv, "cleaned_data.csv")

    summary_text = "\n".join(change_log) or "No changes made."
    summary_file = BytesIO(summary_text.encode())
    st.download_button("📄 Download Cleaning Summary Report", summary_file, file_name="cleaning_summary.txt")

    # Final Cleaned Data Preview (side by side)
    st.subheader("🧼 Final Cleaned Dataset (Side by Side Preview)")
    st.write("Original (left) vs Cleaned (right)")

    preview_rows = 15
    if len(df) <= preview_rows:
        preview_df = pd.concat(
            [original_df.reset_index(drop=True), df.reset_index(drop=True)],
            axis=1, keys=["Original", "Cleaned"]
        )
        st.dataframe(preview_df)
    else:
        preview_df = pd.concat(
            [original_df.head(preview_rows).reset_index(drop=True), df.head(preview_rows).reset_index(drop=True)],
            axis=1, keys=["Original", "Cleaned"]
        )
        st.dataframe(preview_df)
        if st.button("Preview Full Side-by-Side Data"):
            full_preview_df = pd.concat(
                [original_df.reset_index(drop=True), df.reset_index(drop=True)],
                axis=1, keys=["Original", "Cleaned"]
            )
            csv = full_preview_df.to_csv(index=False)
            st.markdown(
                f'<a href="data:text/csv;charset=utf-8,{csv.replace("\n", "%0A").replace(",", "%2C")}" target="_blank">Open Full Side-by-Side Data in New Tab</a>',
                unsafe_allow_html=True
            )
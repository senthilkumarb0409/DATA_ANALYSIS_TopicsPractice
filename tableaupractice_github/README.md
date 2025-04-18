Tableau
![image](https://github.com/user-attachments/assets/9f04dbac-e03e-4f02-b9b2-05c92c603baa)

 
enabling data-driven decision-making
 
 ![image](https://github.com/user-attachments/assets/4c002b5f-7f30-4950-b4ac-594627432827)

 
 
Downloading Tableau 
 
 
 
Tableau Desktop - Professional version
 
Option - 1
 
Tableau public download link
 
https://www.tableau.com/products/public/download
 
 
Option 2
 
Tableau Desktop download link for windows users
 
https://www.tableau.com/products/desktop/download
 
 
1.	Tableau Desktop download after 20 and try to experience the feature which missed in public version
 
 
How to connect data source in Tableau
 
1.	Explain this with Tableau data source connectivity page
 
 
TYPES OF CONNECTIONS
-LIVE
*IT S A REAL TIME UPDATES
-EXTRACT
*IT S SNAPSHAT OF COPY OF DATA
* SCHEDULE REFRESH

15-04-2024
 
Types of extensions 
 
-twb-tableau workbook - 
 
•	This file type is a plain XML file that contains all the necessary information for Tableau to connect to data sources, define visualizations, and create dashboards.
•	.twb files do not include the actual data. They contain references to data sources, queries, and instructions on how to visualize the data.
•	Since .twb files only contain references to data sources, they are generally smaller in size compared to .twbx files.
 
 
-twbx-tableau packeged workbook - save with packaged workbook with datasource - large memory
 
•	This file type is a packaged version of a Tableau workbook. It contains the workbook itself (.twb) along with any external data sources and images used within the workbook.
•	.twbx files bundle everything together into a single file, making it easier to share and transport workbooks, especially when they rely on external data sources.
•	.twbx files are larger in size compared to .twb files because they include the actual data and any other resources needed for the workbook.
•	They are essentially zip archives that contain the .twb file along with a folder containing any external files referenced in the workbook.
 
 
-tds-tableau datasource - only save data connection  information
 
•	TDS files are XML files that represent a Tableau data source. They contain metadata about the data source, including information about the connection to the data, data schema, and any transformations applied.
•	Unlike TWB files, TDS files do not contain visualizations or worksheets. They are specifically used to define and manage connections to data sources.
•	TDS files can be created and shared independently of workbooks. They allow users to maintain consistent connections to data sources across multiple workbooks.
 
 
-tdsx-tableau packaged datasource
 
•	TDSX files are packaged versions of TDS files. They include the TDS file itself along with any local data files associated with the data source.
•	Similar to TWBX files, TDSX files bundle everything needed for the data source into a single file, making it easier to share and transport.
•	TDSX files are useful when you need to share a data source along with its associated data, ensuring that others can connect to the data source without needing access to the original data files.
•	They are essentially zip archives that contain the TDS file along with any necessary local data files.
 
 

 
-tbm-tableau bookmark - 
 
TBM (Tableau Bookmark):
•	TBM files are essentially snapshots of Tableau workbooks or views.
•	They capture the state of a particular workbook or view at a specific point in time, including the layout, filters, parameters, and data displayed.
•	TBM files allow users to save and share specific views or configurations of Tableau workbooks with others.
•	They are useful for sharing insights, collaborating on analyses, or documenting particular states of data visualization projects.
 
 
.Hyper exten
 
Fir extracting data and save in local machine
 
 
•	tps-tableau preference
 
•	You can create you own color palette
 
<?xml version='1.0'?>
 
<workbook>
<preferences>
 
<color-palette name = "test" type = "regular">
<color>#033445</color>
        <color>#033445</color>
<color>#CD5C5C</color>
<color>#C0C0C0</color>        
<color>#FA8072</color>        
<color>#FF0000</color>
 
 
</color-palette>
 
</preferences>
</workbook>
 
 
17-04-2025

DATA TYPES
-NUMBER
 *WHOLE - 19
 *DECIMAL - 19.5
-STRING - tesafsdf455
-DATE - 25/01/2025
-DATE TIME - 25/01/2025 07:52AM
-GEOGRAPHY - city,state
-BOOLEAN - True, False
 
1.	 
DIMENSION  - 
 
In Tableau, dimensions are essentially categorical variables or attributes that provide context or categories for your data. They are typically qualitative data that you can use to segment, group, or filter your data.
 
For example, if you're analyzing sales data, dimensions could include things like "Product Category," "Customer Segment," or "Region." These dimensions are used to break down the data and provide a basis for comparison or analysis.
 
 
-qualitative values
-it can't be aggregated
-eg name,id,rollno
It represent in blue color.
 
 
Measure - 
 
In Tableau, measures are numerical values that you typically perform calculations on or aggregate in some way. Measures represent quantitative data and are used to perform mathematical operations like sum, average, count, etc. on your data.
 
For example, in a sales dataset, measures could include "Sales Revenue," "Profit," "Quantity Sold," or "Average Sales Price." These measures provide the numerical values that you want to analyze or visualize.
 
-quantitative values
-it can be aggregated
-eg sales, profit,withdrawals
It represent in green color.
 
discrete-individually separate and segment ,finite values.
continuous-forming an unbroken whole without any interpretation.
 
It represent in blue color.
It represent in green color.


Workseet
-it contains data,analytics,shelves,single view,legends
 
Row shelf, Column shelf,filter shelf,pages shelf
 
Page shelf - similar to flip book animation
Change order date to drop down and choose date value month
Change chart type to circle
 
marks
-color
-size
-label
-detail
-tooltip
-angle - 
-path - 
-shapes -



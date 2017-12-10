# DashboardListDoc-widget v2 RC3.3.7

A small Dashboard Documents grid/list widget plugin for **Evolution CMS 1.4** based on DocLister

Requires snippets: DocLister, DocInfo, If, PhpThumb.

![doclist333](https://user-images.githubusercontent.com/7342798/33715917-865d2b64-db54-11e7-9eba-89f12b368be5.png)

## Features:
- **Configurable toggle overview row with tvs** (add any tv to the resource toggle overview)
- Main **Doclister parameters** available in plugin config
- **More actions buttons**: edit, preview, move, publish/unpublish, create resource here, delete, overview 
- **Hide some actions buttons to get more space**: you can hide from plugin settings: move, publish/unpublish, create resource here, delete
- **parent column** (click on parent name to view children tab)  [optional]
- **right click Context Menu on Parent** field (view childern, edit, add resource here, add weblink here)
- **tv columns**: add custom tv in sortable columns  [optional]
- **image tv** in overview or column  [optional]
- **Sortable columns** (title/parent/date/custom tv columns)
- **Filtering** (search)
- **Filter options** (choose "search in")
- **Pagination**
- **Status Filter** (published, unpublished, deleted) [optional]
- **Edit in Evo Modal**: edit and create documents in Evo (1.4) modal/popup [optional]
- **Full Localstorage support**: state of pagination , search and sorting is always saved in localhost - so when you go back to the dashboard, you dont need to search or sort again

### Tv image in overview row

![doclist-image-overview](https://user-images.githubusercontent.com/7342798/33797559-a030c3b8-dd0a-11e7-8478-d91035e31c86.png)

### Tv image in column

![doclist-inline-img](https://user-images.githubusercontent.com/7342798/33797565-a85b0896-dd0a-11e7-8c91-ac1f8d7f02ce.png)

### Parent resource column Context Menu

![doclist-ctx](https://user-images.githubusercontent.com/7342798/33797568-b059e99a-dd0a-11e7-806b-0089f6982d55.png)

# Plugin Settings

### Widget Permissions Settings

* **Show widget for**: All, Admin Only , Excluded Admin, This Role only*, This user only**
* **Show only to this role id**: enter the role id*
* **Show only to this username**: enter the username**

### Widget Style Settings

* **Widget Title**: 
* **Widget icon**: font awesome icon
* **Widget position**: sort widget position
* **Widget x size**: width in bootstrap col-
* **Widget Title Background color**:
* **Widget title color**:

### Doclister params Settings

* **Parent folder for List documents**: parents
* **Max items in List**: display
* **Depht**: depth 
* **Hide Folders**: addWhereList isfolder=0
* **Show Deleted and Unpublished**: showNoPublish

### Widget & Grid Settings

* **Show Create Resource Buttons**: Show header Create Resource Buttons buttons (parent id from parents parameter)
* **Show Status Filter**: Show published/unpublished/deleted dropdown select filter (require Show Deleted and Unpublished - ```YES```)
* **Display Title in title column**: choose which title display in title column (pagetitle/longtitle/menutile)
* **Show Parent Column**: Show Resource Parent Column
* **Tv column**: The list of tvs to add as sortable columns. example: ```[+longtitle+],[+menuindex+]```
* **Tv Sort type**: Sort mode for tv columns- text(for any text tv)/number(for numbers tv, like price)/date(date is not yet supported). example for longtitle and menuindex: ```text,number```
* **Show Image TV**: enter tv name. ie: ```image```
* **how image Tv in**: choose where show the image thumbnail: ```overview``` row or ```column```
* **verview Tv Fields**: The list of tvs to add in toogle overview row. example ```[+longtitle+],[+description+],[+introtext+],[+documentTags+]```
* **Overview TV headings**: titles for tvs in overview. example: ```Long Title,Description,Introtext,Tags```
* **Edit docs in modal**: edit and create resources in new evo 1.4 modal window

### Buttons (show/hide) Settings

note: hides the button to everyone, even if the user has permissions
* **Show Move Button**
* **Show Create Resource here Button**
* **Show Publish Button**
* **Show Delete Button**



# To Do

- **Ajax** pagination/load of resources

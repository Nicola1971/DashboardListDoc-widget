# DashboardListDoc-widget v2 RC3.3.5

A small Dashboard Documents grid/list widget plugin for **Evolution CMS 1.4** based on DocLister

Requires snippets: DocLister, DocInfo, If, PhpThumb.

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

![doclist333](https://user-images.githubusercontent.com/7342798/33715917-865d2b64-db54-11e7-9eba-89f12b368be5.png)

## Parameters

### Widget Permissions

* Show widget for: All, Admin Only , Excluded Admin, This Role only*, This user only**
* Show only to this role id: enter the role id*
* Show only to this username: enter the username**

### Widget Style

* Widget Title: 
* Widget icon: font awesome icon
* Widget position: sort widget position
* Widget x size: width in bootstrap col-
* Widget Title Background color:
* Widget title color:

### Doclister params

* Parent folder for List documents: parents
* Max items in List: display
* Depht: depth 
* Hide Folders: addWhereList isfolder=0
* Show Deleted and Unpublished: showNoPublish

### Widget UI & grid

* Show Status Filter: Show published/unpublished/deleted dropdown select filter (require Show Deleted and Unpublished - YES)
* Show Parent Column: Show Resource Parent Column
* Tv columns: The list of tvs to add as sortable columns. example: [+longtitle+],[+menuindex+]
* Tv Sort type: Sort mode for tv columns- text(for any text tv)/number(for numbers tv, like price)/date(date is not yet supported). example for longtitle and menuindex: text,number
* Show Image TV: enter tv name. ie: image
* Show image Tv in: choose where show the image thumbnail: overview row or column
* Overview Tv Fields: The list of tvs to add in toogle overview row. example [+longtitle+],[+description+],[+introtext+],[+documentTags+]
* Overview TV headings: titles for tvs in overview. example: Long Title,Description,Introtext,Tags
* Edit docs in modal: edit and create resources in new evo 1.4 modal window

### Buttons Settings (show/hide)

note: hides the button to everyone, even if the user has permissions
* Show Move Button
* Show Create Resource here Button
* Show Publish Button
* Show Delete Button



## To Do

- Ajax pagination/load of resources

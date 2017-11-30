/**
 * DashboardDocList 
 *
 * Dashboard Documents list widget plugin for Evolution CMS
 * @author    Nicola Lambathakis
 * @category    plugin
 * @version    3.2.1
 * @license	   http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnManagerWelcomeHome,OnManagerMainFrameHeaderHTMLBlock
 * @internal    @installset base
 * @internal    @modx_category Dashboard
 * @author      Nicola Lambathakis http://www.tattoocms.it/
 * @documentation Requirements: This plugin requires Evolution 1.3.1 or later
 * @reportissues https://github.com/Nicola1971/WelcomeStats-EvoDashboard-Plugin/issues
 * @link        
 * @lastupdate  30/11/2017
 * @internal    @properties &wdgVisibility=Show widget for:;menu;All,AdminOnly,AdminExcluded,ThisRoleOnly,ThisUserOnly;All &ThisRole=Show only to this role id:;string;;;enter the role id &ThisUser=Show only to this username:;string;;;enter the username  &wdgTitle= Widget Title:;string;Documents List  &wdgicon= widget icon:;string;fa-pencil  &wdgposition=widget position:;list;1,2,3,4,5,6,7,8,9,10;1 &wdgsizex=widget x size:;list;12,6,4,3;12 &ParentFolder=Parent folder for List documents:;string;0 &ListItems=Max items in List:;string;50 &showParent= Show Parent Column:;list;yes,no;yes &TvColumn=Show Tv column:;string;;;enter tv name &tablefields= Overview Tv Fields:;string;[+longtitle+],[+description+],[+introtext+],[+documentTags+] &tableheading=Overview TV headings:;string;Long Title,Description,Introtext,Tags &hideFolders= Hide Folders:;list;yes,no;no &showPublishedOnly= Show Deleted and Unpublished:;list;yes,no;yes &dittolevel= Depht:;string;3 &showMoveButton= Show Move Button:;list;yes,no;yes &showPublishButton= Show Publish Button:;list;yes,no;yes &showDeleteButton= Show Delete Button:;list;yes,no;yes &HeadBG= Widget Title Background color:;string; &HeadColor= Widget title color:;string;
*/
/******
DashboardDocList 3.2
OnManagerWelcomeHome,OnManagerMainFrameHeaderHTMLBlock
&wdgVisibility=Show widget for:;menu;All,AdminOnly,AdminExcluded,ThisRoleOnly,ThisUserOnly;All &ThisRole=Show only to this role id:;string;;;enter the role id &ThisUser=Show only to this username:;string;;;enter the username  &wdgTitle= Widget Title:;string;Documents List  &wdgicon= widget icon:;string;fa-pencil  &wdgposition=widget position:;list;1,2,3,4,5,6,7,8,9,10;1 &wdgsizex=widget x size:;list;12,6,4,3;12 &ParentFolder=Parent folder for List documents:;string;0 &ListItems=Max items in List:;string;50 &showParent= Show Parent Column:;list;yes,no;yes &TvColumn=Show Tv column:;string;;;enter tv name &tablefields= Overview Tv Fields:;string;[+longtitle+],[+description+],[+introtext+],[+documentTags+] &tableheading=Overview TV headings:;string;Long Title,Description,Introtext,Tags &hideFolders= Hide Folders:;list;yes,no;no &showPublishedOnly= Show Deleted and Unpublished:;list;yes,no;yes &dittolevel= Depht:;string;3 &showMoveButton= Show Move Button:;list;yes,no;yes &showPublishButton= Show Publish Button:;list;yes,no;yes &showDeleteButton= Show Delete Button:;list;yes,no;yes &HeadBG= Widget Title Background color:;string; &HeadColor= Widget title color:;string

***/
// get manager role
$internalKey = $modx->getLoginUserID();
$sid = $modx->sid;
$role = $_SESSION['mgrRole'];
$user = $_SESSION['mgrShortname'];
// show widget only to Admin role 1
if(($role!=1) AND ($wdgVisibility == 'AdminOnly')) {}
// show widget to all manager users excluded Admin role 1
else if(($role==1) AND ($wdgVisibility == 'AdminExcluded')) {}
// show widget only to "this" role id
else if(($role!=$ThisRole) AND ($wdgVisibility == 'ThisRoleOnly')) {}
// show widget only to "this" username
else if(($user!=$ThisUser) AND ($wdgVisibility == 'ThisUserOnly')) {}
else {
$e = &$modx->Event;
switch($e->name){
/*load styles with OnManagerMainFrameHeaderHTMLBlock*/
case 'OnManagerMainFrameHeaderHTMLBlock':
$manager_theme = $modx->config['manager_theme'];
if($manager_theme == "EvoFLAT") {
$cssOutput = '
<script src="../assets/plugins/dashboarddoclist/js/footable.min.js"></script>
<script>	
jQuery(function($){
		$(\'#TableList\').footable({
			"paging": {
				"enabled": true
			},
			"filtering": {
				"enabled": true
			},
			"sorting": {
				"enabled": true
			},
		});
	});
</script>
<link type="text/css" rel="stylesheet" href="../assets/plugins/dashboarddoclist/css/footable.evo.css">
<link type="text/css" rel="stylesheet" href="../assets/plugins/dashboarddoclist/css/list_flat.css">';
}
else {
$cssOutput = '
<script src="../assets/plugins/dashboarddoclist/js/footable.min.js"></script>
<script>	
jQuery(function($){
		$(\'#TableList\').footable({
			"paging": {
				"enabled": true
			},
			"filtering": {
				"enabled": true
			},
			"sorting": {
				"enabled": true
			},
		});
	});
</script>
<link type="text/css" rel="stylesheet" href="../assets/plugins/dashboarddoclist/css/footable.evo.css">
<link type="text/css" rel="stylesheet" href="../assets/plugins/dashboarddoclist/css/list.css">';
		}
$jsOutput ='';
$e->output($cssOutput.$jsOutput);
break;
case 'OnManagerWelcomeHome':
// get language
global $modx,$_lang;
// get plugin id
$result = $modx->db->select('id', $this->getFullTableName("site_plugins"), "name='{$modx->event->activePlugin}' AND disabled=0");
$pluginid = $modx->db->getValue($result);
if($modx->hasPermission('edit_plugin')) {
$button_pl_config = '<a data-toggle="tooltip" href="javascript:;" title="' . $_lang["settings_config"] . '" class="text-muted pull-right" onclick="parent.modx.popup({url:\''. MODX_MANAGER_URL.'?a=102&id='.$pluginid.'&tab=1\',title1:\'' . $_lang["settings_config"] . '\',icon:\'fa-cog\',iframe:\'iframe\',selector2:\'#tabConfig\',position:\'center center\',width:\'80%\',height:\'80%\',wrap:\'evo-tab-page-home\',hide:0,hover:0,overlay:1,overlayclose:1})" ><i class="fa fa-cog fa-spin-hover" style="color:'.$HeadColor.';"></i> </a>';
}
$modx->setPlaceholder('button_pl_config', $button_pl_config);

//output
$WidgetOutput = isset($WidgetOutput) ? $WidgetOutput : '';
$TvColumn = isset($TvColumn) ? $TvColumn : '';
$tablefields = isset($tablefields) ? $tablefields : '[+longtitle+],[+description+],[+introtext+],[+documentTags+]';
$tableheading = isset($tableheading) ? $tableheading : 'Long Title,Description,Introtext,Tags';

//get Tv vars Heading Titles from Module configuration (ie: Page Title,Description,Date)
//get Tv vars fields from Plugin configuration (ie: [+pagetitle+],[+description+],[+date+])

$tharr = explode(",","$tableheading");
$tdarr = explode(",","$tablefields");
foreach (array_combine($tharr, $tdarr) as $thval => $tdval){
    $thtdfields .=  "
    <li><b>" . $thval . "</b>: " . $tdval . "</li>
    ";
}

$parentId = $ParentFolder;
$dittototal = $ListItems;
$rowTpl = '@CODE: <tr>
<td aria-expanded="false" class="footable-toggle"> <span class="label label-info">[+id+]</span></td>
<td class="footable-toggle"><a target="main" data-title="edit?" class="dataConfirm [[if? &is=`[+published+]:=:0` &then=`unpublished`]] [[if? &is=`[+deleted+]:=:1` &then=`deleted`]]" href="index.php?a=27&id=[+id+]" title="' . $_lang["edit_resource"] . '">[+pagetitle+]</a></td> ';
if ($showParent == yes) {
$rowTpl .= '
<td aria-expanded="false" class="footable-toggle"> 
[[if? &is=`[+parent+]:not:0`&then=`<a target="main" href="index.php?a=3&id=[+parent+]&tab=1" title="'.$_lang["view_child_resources_in_container"].'">[[DocInfo? &docid=`[+parent+]` &field=`pagetitle`]]</a>`]]
</td>';
}
if ($TvColumn != '') {
$rowTpl .= '
<td aria-expanded="false" class="footable-toggle"> 
[+'.$TvColumn.'+]
</td>';
}
$rowTpl .= '<td class="footable-toggle text-right text-nowrap">[+editedon:date=`%d-%m-%Y`+]</td>
<td style="text-align: right;" class="actions">
<a target="main" href="index.php?a=27&id=[+id+]" title="' . $_lang["edit_resource"] . '"><i class="fa fa-pencil-square-o"></i></a> <a href="[(site_url)]index.php?id=[+id+]" target="_blank" title="' . $_lang["preview_resource"] . '"><i class="fa fa-eye"></i></a> ';
if ($showMoveButton == yes) { 
$rowTpl .= '<a target="main" href="index.php?a=51&id=[+id+]" title="' . $_lang["move_resource"] . '"><i class="fa fa-arrows"></i></a> ';
}
if ($showPublishButton == yes) { 
$rowTpl .= '[[if? &is=`[+deleted+]:=:0` &then=`[[if? &is=`[+published+]:=:1` &then=` 
<a target="main" href="index.php?a=62&id=[+id+]" class="confirm" onClick="window.location.reload();" title="' . $_lang["unpublish_resource"] . '"><i class="fa fa-arrow-down"></i></a>  
`&else=`
<a target="main" href="index.php?a=61&id=[+id+]" class="confirm" onClick="window.location.reload();" title="' . $_lang["publish_resource"] . '"><i class="fa fa-arrow-up"></i></a>  
`]]
`&else=`
<span style="opacity:0; margin-right:-6px;" class="text-muted" title="publish"><i class="fa fa-arrow-up"></i></span>  
`]]
';
}
 
if ($showDeleteButton == yes) { 
$rowTpl .= '[[if? &is=`[+deleted+]:=:0` &then=` 
<a target="main" href="index.php?a=6&id=[+id+]" title="' . $_lang["delete_resource"] . '"  onClick="window.location.reload()();"><i class="fa fa-trash"></i></a>  
`&else=`
<a target="main" href="index.php?a=63&id=[+id+]" title="' . $_lang["undelete_resource"] . '"  onClick="window.location.reload()();"><i class="fa fa-arrow-circle-o-up"></i></a>  
`]]';
}

$rowTpl .= '<span class="footable-toggle" style="margin-left:-4px;" title="' . $_lang["resource_overview"] . '"><i class="footable-toggle fa fa-info"></i></span></td>

<td class="resource-details">
<div class="text-small">
<ul>        
'.$thtdfields.'
</ul>
</div>
</td>
</tr>
';
if ($showParent == yes) {
$parentColumnHeader = '
<th data-type="text">[%resource_parent%]</th> ';
}

//DocListerTvFields
$find = array('[+','+]');
$replace = array('','');
$DocListerTvs = str_replace($find,$replace,$tablefields);
$DocListerTvFields = $DocListerTvs;
if ($TvColumn != '') {
$TvFields = ''.$DocListerTvFields.','.$TvColumn.'';
$TvColumnHeader = '
<th data-type="text">'.$TvColumn.'</th> ';
}
else {
$TvFields = $DocListerTvFields;
}
// DocLister parameters
$params['debug'] = '0';	//enable to debug listing
$params['id'] = 'doclistwdg';
$params['parents'] = $parentId;
$params['depth'] = $dittolevel;
$params['tpl'] = $rowTpl;
$params['tvPrefix'] = '';
$params['tvList'] = $TvFields;
$params['display'] = $dittototal;		
if ($showPublishedOnly == yes) {
$params['showNoPublish'] = '1';
}
if ($hideFolders == yes) {
$wherehideFolders = 'isfolder=0';
$params['addWhereList'] = 'isfolder=0';
}
// run DocLister
$list = $modx->runSnippet('DocLister', $params);
			$widgets['DashboardList'] = array(
				'menuindex' =>''.$wdgposition.'',
				'id' => 'DashboardList'.$pluginid.'',
				'cols' => 'col-md-'.$wdgsizex.'',
				'headAttr' => 'style="background-color:'.$HeadBG.'; color:'.$HeadColor.';"',
				'bodyAttr' => '',
				'cardAttr' => '',
				'icon' => ''.$wdgicon.'',
				'title' => ''.$wdgTitle.' '.$button_pl_config.'',
				'body' => '<div class="widget-stage"><div id ="DashboardList" class="table-responsive">
				<table data-state="true" data-state-key="DashboardList'.$pluginid.'_state" data-paging-size="10" data-show-toggle="false" data-toggle-column="last" data-toggle-selector=".footable-toggle" data-filter-dropdown-title="Search in:" class="table data" id="TableList">
                <thead>
						<tr>
							<th data-type="number" style="width: 1%">[%id%]</th>
							<th data-type="text">[%resource_title%]</th>
							'.$parentColumnHeader.'
							'.$TvColumnHeader.'
							<th data-type="date" data-sorted="true" data-direction="DESC" style="width: 1%">[%page_data_edited%]</th>
							<th data-filterable="false" data-sortable="false" style="width: 1%; text-align: center">[%mgrlog_action%]</th>
							<th data-filterable="false" data-sortable="false" data-breakpoints="all"></th>
						</tr>
					</thead>
                    <tbody>
'.$list.' 
</tbody></table></div></div>',
				'hide' => '0'
			);	
            $e->output(serialize($widgets));
    break;
}
}
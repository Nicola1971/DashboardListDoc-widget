/**
 * DashboardDocList 3.1 
 *
 * Dashboard Docmunts list widget plugin for Evolution CMS
 * @author    Nicola Lambathakis
 * @category    plugin
 * @version    3.1 rc
 * @license	   http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnManagerWelcomeHome,OnManagerMainFrameHeaderHTMLBlock
 * @internal    @installset base
 * @internal    @modx_category Dashboard
 * @author      Nicola Lambathakis http://www.tattoocms.it/
 * @documentation Requirements: This plugin requires Evolution 1.3.1 or later
 * @reportissues https://github.com/Nicola1971/WelcomeStats-EvoDashboard-Plugin/issues
 * @link        
 * @lastupdate  30/08/2017
 * @internal    @properties &wdgVisibility=Show widget for:;menu;All,AdminOnly;show &wdgTitle= Stats widget Title:;string;Documents List  &wdgicon= widget icon:;string;fa-pencil  &wdgposition=widget position:;list;1,2,3,4,5,6,7,8,9,10;1 &wdgsizex=widget x size:;list;12,6,4,3;12 &ParentFolder=Parent folder for List documents:;string;2,15 &ListItems=Max items in List:;string;20 &tablefields= Tv Fields:;string;[+longtitle+],[+description+],[+introtext+],[+documentTags+] &tableheading=TV  heading:;string;Long Title,Description,Introtext,Tags &hideFolders= Hide Folders:;list;yes,no;yes &showPublishedOnly= Show Published Only:;list;yes,no;no &dittolevel= Depht:;string;1 &showMoveButton= Show Move Button:;list;yes,no;yes &showPublishButton= Show Publish Button:;list;yes,no;yes &showDeleteButton= Show Delete Button:;list;yes,no;yes &datarow= widget row position:;list;1,2,3,4,5,6,7,8,9,10;2 &datacol= widget col position:;list;1,2,3,4;1 &datasizex= widget x size:;list;1,2,3,4;2 &datasizey= widget y size:;list;1,2,3,4,5,6,7,8,9,10;4 &WidgetID= Unique Widget ID:;string;DocListBox
*/
// get manager role
$role = $_SESSION['mgrRole'];          
if(($role!=1) AND ($wdgVisibility == 'AdminOnly')) {}
else {
$e = &$modx->Event;
switch($e->name){
/*load styles with OnManagerMainFrameHeaderHTMLBlock*/
case 'OnManagerMainFrameHeaderHTMLBlock':
$cssOutput = '<link type="text/css" rel="stylesheet" href="../assets/plugins/dashboarddoclist/css/list.css">';
$e->output($cssOutput.$jsOutput);
break;
case 'OnManagerWelcomeHome':
// get language
global $modx,$_lang;
// get plugin id
$result = $modx->db->select('id', $this->getFullTableName("site_plugins"), "name='{$modx->event->activePlugin}' AND disabled=0");
$pluginid = $modx->db->getValue($result);
if($modx->hasPermission('edit_plugin')) {
$button_pl_config = '<a data-toggle="tooltip" title="' . $_lang["settings_config"] . '" href="index.php?id='.$pluginid.'&a=102" class="text-muted pull-right" ><i class="fa fa-cog"></i> </a>';
}
$modx->setPlaceholder('button_pl_config', $button_pl_config);
/*Widget Box */

//output
$WidgetOutput = isset($WidgetOutput) ? $WidgetOutput : '';
//events

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
<td data-toggle="collapse" data-target=".collapse'.$WidgetID.'[+id+]"> <span class="label label-info">[+id+]</span></td>
<td><a class="[[if? &is=`[+published+]:=:0` &then=`unpublished`]]" href="index.php?a=27&id=[+id+]" title="edit">[+pagetitle+]</a></td>
<td class="text-right text-nowrap">[+date+]</td>
<td style="text-align: right;" class="actions">
<a href="index.php?a=27&id=[+id+]" title="edit"><i class="fa fa-pencil-square-o"></i></a> <a href="[(site_url)]index.php?id=[+id+]" target="_blank" title="preview"><i class="fa fa-eye"></i></a> ';
if ($showMoveButton == yes) { 
$rowTpl .= '<a href="index.php?a=51&id=[+id+]" title="move"><i class="fa fa-arrows"></i></a> ';
}
if ($showPublishButton == yes) { 
$rowTpl .= '[[if? &is=`[+published+]:=:1` &then=` 
<a href="index.php?a=62&id=[+id+]" title="unpublish"><i class="fa fa-arrow-down"></i></a>  
`&else=`
<a href="index.php?a=62&id=[+id+]" title="publish"><i class="fa fa-arrow-up"></i></a>  
`]]';
}
 
if ($showDeleteButton == yes) { 
$rowTpl .= '<a href="index.php?a=6&id=[+id+]" title="delete"><i class="fa fa-trash-o"></i></a>  ';
}

$rowTpl .= ' <a style="margin-left:3px;" title="' . $_lang["resource_overview"] . '" data-toggle="collapse" data-target=".collapse'.$WidgetID.'[+id+]"><i class="fa fa-info"></i></a></td>

</tr>
<tr class="resource-overview-accordian collapse collapse'.$WidgetID.'[+id+]">
<td colspan="4">
<div class="overview-body text-small">
<ul>        
'.$thtdfields.'
</ul>
</div>
</td>
</tr>
';
//DocListerTvFields
$find = array('[+','+]');
$replace = array('','');
$DocListerTvs = str_replace($find,$replace,$tablefields);
$DocListerTvFields = $DocListerTvs;
// DocLister parameters
$params['debug'] = '0';	//enable to debug listing	
$params['parents'] = $parentId;
$params['depth'] = $dittolevel;
$params['tpl'] = $rowTpl;
$params['tvPrefix'] = '';
$params['tvList'] = $DocListerTvFields;
$params['display'] = $dittototal;
//$params['total'] = $dittototal;
$params['showParent'] = '1';
$params['paginate'] = 'pages';
$params['PrevNextAlwaysShow'] = '1';
$params['TplNextP'] = '@CODE:<li><a href="[+link+]">next</a></li>';
$params['TplPrevP'] = '@CODE:<li><a href="[+link+]">prev</a></li>';
$params['TplPage'] = '@CODE: [+num+]';
$params['TplCurrentPage'] = '@CODE: [+num+]';
		
if ($showPublishedOnly == yes) {
$params['showNoPublish'] = '0';
}
if ($hideFolders == yes) {
$wherehideFolders = 'isfolder=0';
$params['addWhereList'] = 'isfolder=0';
}
// run Ditto
$list = $modx->runSnippet('DocLister', $params);
			$widgets['DashboardList'] = array(
				'menuindex' =>''.$wdgposition.'',
				'id' => 'DashboardList'.$pluginid.'',
				'cols' => 'col-md-'.$wdgsizex.'',
				'icon' => ''.$wdgicon.'',
				'title' => ''.$wdgTitle.' '.$button_pl_config.'',
				'body' => '<div class="widget-stage"><div class="table-responsive">
				<table class="table data" id="TableList">
                <thead>
						<tr>
							<th style="width: 1%">[%id%]</th>
							<th>[%resource_title%]</th>
							<th style="width: 1%">[%page_data_edited%]</th>
							<th style="width: 1%; text-align: center">[%mgrlog_action%]</th>
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

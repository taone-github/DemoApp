var path = '/wps/bki/';
var tree_tpl = {
	'target'  : '_self',	// name of the frame links will be opened in
							// other possible values are: _blank, _parent, _search, _self and _top

	'icon_e'  : path+'images/empty.gif', // empty image 
	'icon_l'  : path+'images/line.gif',  // vertical line

/*'icon_32' : 'images/base.gif',   // root leaf icon normal
    'icon_36' : 'images/base.gif',   // root leaf icon selected

	'icon_48' : 'images/base.gif',   // root icon normal
	'icon_52' : 'images/base.gif',   // root icon selected
	'icon_56' : 'images/base.gif',   // root icon opened
	'icon_60' : 'images/base.gif',   // root icon selected
*/

	'icon_32' : path+'images/plusbottom_noline.gif',   // root leaf icon normal
    'icon_36' : path+'images/plusbottom_noline.gif',   // root leaf icon selected

	'icon_48' : path+'images/plusbottom_noline.gif',   // root icon normal
	'icon_52' : path+'images/plusbottom_noline.gif',   // root icon selected
	'icon_56' : path+'images/plusbottom_noline.gif',   // root icon opened
	'icon_60' : path+'images/plusbottom_noline.gif',   // root icon selected

	//'icon_16' : 'images/folder_i.gif', // node icon normal
	'icon_16' : path+'images/blank.gif', // node icon normal
	'icon_20' : path+'images/blank.gif', // node icon selected  .....change from images/folderopen.gif to blank.gif
	'icon_24' : path+'images/blank.gif', // node icon opened
	'icon_28' : path+'images/blank.gif', // node icon selected opened

	//'icon_0'  : 'images/page_.gif', // leaf icon normal
	//'icon_4'  : 'images/page_.gif', // leaf icon selected
	'icon_0'  : path+'images/blank.gif', // leaf icon normal
	'icon_4'  : path+'images/blank.gif', // leaf icon selected
	
	'icon_2'  : path+'images/joinbottom.gif', // junction for leaf
	'icon_3'  : path+'images/join.gif',       // junction for last leaf
	'icon_18' : path+'images/plusbottom.gif', // junction for closed node ....change from images/plusbottom.gif to NavigartionCollapsed.gif
	//'icon_18' : 'images/NavigationCollapsed.gif', // junction for closed node
	'icon_19' : path+'images/plus_i.gif',       // junctioin for last closed node
	'icon_26' : path+'images/minusbottom.gif',// junction for opened node
	'icon_27' : path+'images/minus_i.gif'       // junctioin for last opended node
};


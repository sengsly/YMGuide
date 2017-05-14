//
SelectLanguage.enabled= false;
SelectLanguage.Button.enabled= false;
optScanList=["scanBy.optFileName","scanBy.optFileHint"];
function mb(str) {
	fscommand("mb", str);
}
//------------------------------------------------------------------------------------------------------------
/// constructor languagec
function DynamicMove(objList, selectedName, Direction) {

	var xDistanceOld;
	var yDistanceOld;
	var objFound;
	var objLastFound;
	var iRow;
	var iColumn;
	var bFound;
	//var iPoint = new Object();
	selectedObj=eval(selectedName);
	for(i=0;i<objList.length;i++){
		//trace("i="+i);
		for(j=0;j<objList[i].length;j++){
			iObject=eval(objList[i][j]);
			if(selectedName.toLowerCase()==objList[i][j].toLowerCase()){
				bFound=true;
				break;
			}
		}
		if (bFound) break;
	}
	//found:
	switch(Direction){
	case "Right":
		for(k=j+1;k<objList.length;k++){
			iObject=eval(objList[i][k]);
			if( (iObject._visible and iObject.enabled) and (iObject._parent._visible and iObject._parent.enabled) ){
				objFound=iObject;
				break;
			}
		}
		break;
	case "Left":
		for(k=j-1;k>=0;k--){
			iObject=eval(objList[i][k]);
			if( (iObject._visible and iObject.enabled) and (iObject._parent._visible and iObject._parent.enabled) ){
				objFound=iObject;
				break;
			}
		}
		break;				
	case "Up":
		for(k=i-1;k>=0;k--){
			for(l=0;l<objList[k].length;l++){
				iObject=eval(objList[k][l]);
				if( (iObject._visible and iObject.enabled) and (iObject._parent._visible and iObject._parent.enabled) ){
					if(objFound==undefined){
						objFound=iObject;
					}else{
//						if( (selectedObj._x - iObject._x)< (selectedObj._x - objFound._x)){
//							objFound=iObject;
//						}
					}
				}
			}
		}
		break;
	case "Down":
		for(k=i+1;k<objList.length;k++){
			for(l=0;l<objList[k].length;l++){
				iObject=eval(objList[k][l]);
				if( (iObject._visible and iObject.enabled) and (iObject._parent._visible and iObject._parent.enabled) ){
					if(objFound==undefined){
						objFound=iObject;
					}else{
					//	if( Math.abs(selectedPoint.x - iPoint.x)< Math.abs(selectedPoint.x - oPoint.x)){
				//			objFound=iObject;
				//		}
					}
				}
			}
			if (objFound!=undefined) break;
		}
		break;
	}
	if(objFound!=undefined){
		if(typeof(objFound)=="movieclip"){
			objstr=substring( objFound,0);
			eval(Replace(objstr, "Movie", "Button")).onRollOver();
		}else{
			Selection.setFocus(objFound);
		}
		return true;
	}
}

function setLanguages(strName, strPath, Scan) {
	this.Name = strName;
	this.Path = strPath;
	this.Scan = Scan;
}
//------------------------------------------------------------------------------------------------------------
/// function return default scan path last selected
function defaultScanPath(strPath) {
	Path.txt.text = "";
	fxml = new XML();
	fxml.load(strPath+"\\Language.xml");
	fxml.onLoad = function() {
		historyPath.length = 0;
		var l = fxml.firstChild.childNodes;
		Path.txt.text = l[3].attributes.Path;
		historyPath[historyPath.length] = l[3].attributes.Path;
		if (l[3].childNodes.length>0) {
			for (var i = 0; i<l[3].childNodes.length; i++) {
				historyPath[historyPath.length] = l[3].childNodes[i].childNodes[0].nodeValue;
			}
			FirstDisplayHistoryItem(historyPath.length);
		} else {
			historyPath.length = 0;
			FirstDisplayHistoryItem(historyPath.length);
		}
		delete (fxml);
		delete (l);
		delete (strPath);
	};
}
//------------------------------------------------------------------------------------------------------------
/// for change color
function SelectMovieClip(ObjName) {
	ChangeColorAlpha(StoreNameSelected, button_color, button_alpha);
	ChangeColorAlpha(ObjName, button_color_selected, button_alpha_selected);
	StoreNameSelected = ObjName;
}
//------------------------------------------------------------------------------------------------------------
function ChangeColorAlpha(Na, ColorValue1, AlphaValue1) {
	myColor = new Color(Na);
	myColor.setRGB(ColorValue1);
	eval(Na)._alpha = AlphaValue1;
}
//------------------------------------------------------------------------------------------------------------
function ChangeColorNoAlpha(Na, ColorValue1) {
	myColor = new Color(Na);
	myColor.setRGB(ColorValue1);
}
//------------------------------------------------------------------------------------------------------------
/// function enabled
// Option scan by
function getObjName(varObj){
	objstr=substring( varObj,0);
	objstr=objstr.substr( objstr.indexOf(".",0)+1);
	return objstr;
}
function optGroupEnabled(groupList,selectedItem){

	var objSelected=getObjName(selectedItem);
	for(i=0;i<grouplist.length;i++){
		objItem=eval(grouplist[i]);
		if(objSelected==grouplist[i])
		{			
			objItem.check._visible=true;
		}else{
			objItem.check._visible=false;
		}
	}
}

function enableScanby(Type) {

	switch (Type) {
	case 0 :
		optGroupEnabled(optScanList,eval("scanBy.optFileName"));
		break;
	case 1 :
		//optGroupEnabled(optScanList,"scanBy.optFileName")
		break;
	case 2:
		optGroupEnabled(optScanList,eval("scanBy.optFileHint"));
		break;
	}

/*
	newScanby = Type;
	if (Type == "File") {
		scanBy.optFileName.check._visible = true;
		scanBy.optFileName.Button.enabled = true;
		scanBy.optTime.check._visible = false;
		scanBy.optTime.Button.enabled = true;
		enabledScanbyFileName(true);
		enabledScanbyTime(false);
		enableFile("Time");
		fscommand("ScanBy", 0);
	} else {
		scanBy.optFileName.check._visible = false;
		scanBy.optFileName.Button.enabled = true;
		scanBy.optTime.check._visible = true;
		scanBy.optTime.Button.enabled = false;
		enabledScanbyFileName(false);
		enabledScanbyTime(true);
		enableOptionScaneByTimeTrackNumber("ID");
		fscommand("ScanBy", 1);
	}
	*/
}
//------------------------------------------------------------------------------------------------------------
// Option time
function enableFile(Type) {
	newFile = Type;
	if (Type == "ID") {
		Option.File.optFileName.check._visible = false;
		Option.File.optFileName.Button.enabled = true;
		Option.File.optID.check._visible = true;
		Option.File.optID.Button.enabled = false;
		fscommand("FileType", 1);
	} else {
		Option.File.optFileName.check._visible = true;
		Option.File.optFileName.Button.enabled = false;
		Option.File.optID.check._visible = false;
		Option.File.optID.Button.enabled = true;
		fscommand("FileType", 0);
	}
}
//------------------------------------------------------------------------------------------------------------
// Option scanc by time
function enableOptionScaneByTimeTrackNumber(Type) {
	newFile = Type;
	if (Type == "ID") {
		Option.TimeFile.optFileName.check._visible = false;
		Option.TimeFile.optFileName.Button.enabled = true;
		Option.TimeFile.optID.check._visible = true;
		Option.TimeFile.optID.Button.enabled = false;
		fscommand("FileType", 1);
	} else {
		Option.TimeFile.optFileName.check._visible = true;
		Option.TimeFile.optFileName.Button.enabled = false;
		Option.TimeFile.optID.check._visible = false;
		Option.TimeFile.optID.Button.enabled = true;
		fscommand("FileType", 0);
	}
}
//------------------------------------------------------------------------------------------------------------
// After found Rename
function enabledCheckBox(TF) {
	if (TF == true) {
		Option.After.chkProduct.Button.enabled = TF;
		Option.After.chkAlbum.Button.enabled = TF;
		Option.After.chkTrack.Button.enabled = TF;
		Option.After.chkRename.check._visible = TF;
		Option.After.lblProduct.setTextFormat(f);
		Option.After.lblAlbum.setTextFormat(f);
		Option.After.lblTrack.setTextFormat(f);
	} else {
		Option.After.chkProduct.Button.enabled = TF;
		Option.After.chkAlbum.Button.enabled = TF;
		Option.After.chkTrack.Button.enabled = TF;
		Option.After.chkRename.check._visible = TF;
		Option.After.lblProduct.setTextFormat(e);
		Option.After.lblAlbum.setTextFormat(e);
		Option.After.lblTrack.setTextFormat(e);
	}
}
//------------------------------------------------------------------------------------------------------------
// enable when click scan by file name
function enabledScanbyFileName(TF) {
	Option.File._visible = TF;
}
//------------------------------------------------------------------------------------------------------------
// enable when click scan by time
function enabledScanbyTime(TF) {
	Option.TimeFile._visible = TF;
	Option.Time._visible = TF;
	Option.frm._visible = TF;
	Option.lblTimeOption._visible = TF;
	Option.After._visible = TF;
}
//------------------------------------------------------------------------------------------------------------
/// Display Languages
function Display_label_Language(Index, Count) {
	for (var j = 0; j<4; j++) {
		if (j<Count) {
			eval("SelectLanguage.SelectLan.ind"+j).text = Index;
			eval("SelectLanguage.SelectLan.Text"+j).text = arrLan[Index].Name;
			eval("SelectLanguage.SelectLan.Text"+j).setTextFormat(f);
			eval("SelectLanguage.SelectLan.Text"+j)._visible = true;
			eval("SelectLanguage.SelectLan.Button"+j)._visible = true;
			Index += 1;
		} else {
			eval("SelectLanguage.SelectLan.ind"+j).text = "";
			eval("SelectLanguage.SelectLan.Text"+j).text = "";
			eval("SelectLanguage.SelectLan.Text"+j)._visible = false;
			eval("SelectLanguage.SelectLan.Button"+j)._visible = false;
		}
	}
}
//------------------------------------------------------------------------------------------------------------
function FirstDisplayLanguageItem(n) {
	// Total all tracks
	FirstDisplay("Label_Language", n, 4);
	Display_label_Language(IndexShowLabel_Language, CountLabel_Language);
}
//------------------------------------------------------------------------------------------------------------
function ClickLanUp() {
	ClickLeft("Label_Language");
	Display_label_Language(IndexShowLabel_Language, CountLabel_Language);
}
//------------------------------------------------------------------------------------------------------------
function ClickLanDown() {
	ClickRight("Label_Language");
	Display_label_Language(IndexShowLabel_Language, CountLabel_Language);
}
//------------------------------------------------------------------------------------------------------------
/// Display History Path
function Display_label_historyPath(Index, Count) {
	for (var j = 0; j<5; j++) {
		if (j<Count) {
			eval("Path.historyFolders.ind"+j).text = Index;
			eval("Path.historyFolders.Text"+j).text = historyPath[Index];
			eval("Path.historyFolders.Text"+j).setTextFormat(f);
			eval("Path.historyFolders.Text"+j)._visible = true;
			eval("Path.historyFolders.Button"+j)._visible = true;
			Index += 1;
		} else {
			eval("Path.historyFolders.ind"+j).text = "";
			eval("Path.historyFolders.Text"+j).text = "";
			eval("Path.historyFolders.Text"+j)._visible = false;
			eval("Path.historyFolders.Button"+j)._visible = false;
		}
	}
}
//------------------------------------------------------------------------------------------------------------
function FirstDisplayHistoryItem(n) {
	if (n>5) {
		Path.historyFolders.ButtonUp.enabled = true;
		Path.historyFolders.ButtonDown.enabled = true;
	} else {
		Path.historyFolders.ButtonUp.enabled = false;
		Path.historyFolders.ButtonDown.enabled = false;
	}
	FirstDisplay("Label_historyPath", n, 5);
	Display_label_historyPath(IndexShowLabel_historyPath, CountLabel_historyPath);
}
//------------------------------------------------------------------------------------------------------------
function ClickHistoryUp() {
	ClickLeft("Label_historyPath");
	Display_label_historyPath(IndexShowLabel_historyPath, CountLabel_historyPath);
}
//------------------------------------------------------------------------------------------------------------
function ClickHistoryDown() {
	ClickRight("Label_historyPath");
	Display_label_historyPath(IndexShowLabel_historyPath, CountLabel_historyPath);
}
//------------------------------------------------------------------------------------------------------------
//***********************************************************************************************************
//	MObj	: Name of Movie clip that button stand
//	Obj1-2	: Type of Button
//	all		: All Button	
//	len		: Length array
//	T		: Type of button Enabled or visible
function Enable_or_Visible(MObj, Obj1, Obj2, all, len, T) {
	if (T == "E") {
		if (all<len) {
			eval(MObj+Obj1).enabled = true;
			eval(MObj+Obj2).enabled = true;
		} else {
			eval(MObj+Obj1).enabled = false;
			eval(MObj+Obj2).enabled = false;
		}
	} else {
		if (all<len) {
			eval(MObj+Obj1)._visible = true;
			eval(MObj+Obj2)._visible = true;
		} else {
			eval(MObj+Obj1)._visible = false;
			eval(MObj+Obj2)._visible = false;
		}
	}
}
//------------------------------------------------------------------------------------------------------------
/// function for progress bar
function Scanning(l) {
	scanProcess.txt.text = l+" %";
	scanProcess.bar._width = ((450*int(l))/100);
}
//------------------------------------------------------------------------------------------------------------
/// function for set volume
function VolumeSet(obj, val) {
	eval(obj+".bar")._width = val;
	var valset = int((100*val)/136);
	eval(obj+".txtVol").text = valset;
	fscommand("setVolume", valSet);
}
//------------------------------------------------------------------------------------------------------------
function seekSet(obj, cur_val, all_length, cur_string, all_string) {
	eval(obj+".knob")._width = ((((cur_val*100)/all_length)*230)/100);
	eval(obj+".txtCurrent").text = cur_string;
	eval(obj+".txtLength").text = all_string;
}
//------------------------------------------------------------------------------------------------------------
function seekSelect(obj, val) {
	fscommand("seekbar", ((val*100)/230));
}
//------------------------------------------------------------------------------------------------------------
/// Display ItemMatch
function Display_label_ItemMatch(Index, Count) {
	deselect("itemMatch.item.");
	for (var j = 0; j<12; j++) {
		if (j<Count) {
			eval("itemMatch.item.ind"+j).text = Index;
			eval("itemMatch.item.Text"+j).text = arrItem[Index];
			eval("itemMatch.item.Text"+j).setTextFormat(f);
			eval("itemMatch.item.Text"+j)._visible = true;
			eval("itemMatch.item.Button"+j)._visible = true;
			if (Index == valItem) {
				eval("itemMatch.item.sel"+valItem)._visible = true;
			}
			Index += 1;
		} else {
			eval("itemMatch.item.ind"+j).text = "";
			eval("itemMatch.item.Text"+j).text = "";
			eval("itemMatch.item.Text"+j)._visible = false;
			eval("itemMatch.item.Button"+j)._visible = false;
		}
	}
}
//------------------------------------------------------------------------------------------------------------
function FirstDisplayItemMatch(n) {
	// Total all tracks
	valItem = 0;
	Enable_or_Visible("itemMatch.item.", "ButtonUp", "ButtonDown", 12, n, "E");
	FirstDisplay("Label_ItemMatch", n, 12);
	Display_label_ItemMatch(IndexShowLabel_ItemMatch, CountLabel_ItemMatch);
	for (var i = 0; i<12; i++) {
		eval("itemMatch.item.sel"+i)._visible = false;
	}
}
//------------------------------------------------------------------------------------------------------------
function ClickItemUp() {
	ClickLeft("Label_ItemMatch");
	Display_label_ItemMatch(IndexShowLabel_ItemMatch, CountLabel_ItemMatch);
}
//------------------------------------------------------------------------------------------------------------
function clickItemDown() {
	ClickRight("Label_ItemMatch");
	Display_label_ItemMatch(IndexShowLabel_ItemMatch, CountLabel_ItemMatch);
}
//------------------------------------------------------------------------------------------------------------
/// Display Path
function Display_label_Path(Index, Count) {
	deselect("correctFile.item.");
	for (var j = 0; j<12; j++) {
		if (j<Count) {
			eval("correctFile.item.ind"+j).text = Index;
			eval("correctFile.item.Text"+j).text = arrCorrectPath[Index];
			eval("correctFile.item.Text"+j).setTextFormat(f);
			eval("correctFile.item.Text"+j)._visible = true;
			eval("correctFile.item.Button"+j)._visible = true;
			if (Index == valFile) {
				eval("correctFile.item.sel"+valFile)._visible = true;
			}
			Index += 1;
		} else {
			eval("correctFile.item.ind"+j).text = "";
			eval("correctFile.item.Text"+j).text = "";
			eval("correctFile.item.Text"+j)._visible = false;
			eval("correctFile.item.Button"+j)._visible = false;
		}
	}
}
//------------------------------------------------------------------------------------------------------------
function FirstDisplayPath(n) {
	// Total all tracks
	valFile = 0;
	Enable_or_Visible("correctFile.item.", "ButtonUp", "ButtonDown", 12, n, "E");
	FirstDisplay("Label_Path", n, 12);
	Display_label_Path(IndexShowLabel_Path, CountLabel_Path);
	for (var i = 0; i<12; i++) {
		eval("correctFile.item.sel"+i)._visible = false;
	}
}
//------------------------------------------------------------------------------------------------------------
function ClickPathUp() {
	ClickLeft("Label_Path");
	Display_label_Path(IndexShowLabel_Path, CountLabel_Path);
}
//------------------------------------------------------------------------------------------------------------
function clickPathDown() {
	ClickRight("Label_Path");
	Display_label_Path(IndexShowLabel_Path, CountLabel_Path);
}
//------------------------------------------------------------------------------------------------------------
function deselect(obj) {
	for (i=0; i<12; i++) {
		eval(obj+"sel"+i)._visible = false;
	}
}
//------------------------------------------------------------------------------------------------------------
// function for fading
// - obj 		: name of object
// - even		: rollOver or rollOut
function fade(obj, event) {
	if (event == "Over") {
		eval(obj+".fo")._visible = true;
		eval(obj+".fi")._visible = false;
		eval(obj+".fo").gotoAndPlay(2);
	} else {
		eval(obj+".fo")._visible = false;
		eval(obj+".fi")._visible = true;
		eval(obj+".fi").gotoAndPlay(2);
	}
}
//------------------------------------------------------------------------------------------------------------
function concate_path(NKP, FP) {
	var cn = "";
	// computer name
	var dr = "";
	// file drive location
	var lo = "";
	// folder
	var ci = 0;
	var cj = 0;
	var tmp = "";
	if ((String(NKP).substr(2, 1) == "/") or (String(NKP).substr(0, 1) == "/")) {
		NKP = replaceString(NKP, "/", "\\");
	}
	if ((String(FP).substr(2, 1) == "/") or (String(FP).substr(0, 1) == "/")) {
		FP = replaceString(FP, "/", "\\");
	}
	if ((String(FP).substr(0, 2)) == "\\\\") {
		return FP;
	} else {
		if ((String(NKP).substr(0, 2)) == "\\\\") {
			for (ci=0; ci<String(NKP).length; ci++) {
				if (String(NKP).substr(ci, 1) == "\\") {
					cj += 1;
				}
				if (cj == 3) {
					cn = String(NKP).substr(0, ci+1);
					dr = String(FP).substr(0, 1);
					lo = String(FP).substr(2);
					return cn+dr+lo;
				}
			}
		} else {
			return FP;
		}
	}
}
//------------------------------------------------------------------------------------------------------------
function replaceString(str, strold, strnew) {
	tmp = "";
	for (sss=0; sss<String(str).length; sss++) {
		if (String(str).substr(sss, 1) == strold) {
			tmp = tmp+strnew;
		} else {
			tmp = tmp+String(str).substr(sss, 1);
		}
	}
	delete (sss);
	return tmp;
}
//------------------------------------------------------------------------------------------------------------
function changeColorCheck(){
	ChangeColorAlpha(scanBy.optFileName.Check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(scanBy.optTime.Check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(scanBy.optFileHint.Check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(exit.chkExit.check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.File.optID.Check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.File.optFileName.Check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.TimeFile.optID.Check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.TimeFile.optFileName.Check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.Time.chkArtist.check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.Time.chkTitle.check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.After.chkRename.check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.After.chkEdit.check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.After.chkProduct.check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.After.chkAlbum.check, button_color_selected, button_alpha_selected);
	ChangeColorAlpha(Option.After.chkTrack.check, button_color_selected, button_alpha_selected);
}
//------------------------------------------------------------------------------------------------------------
function setStatus(val){
	obj = topBar.icon_con;
	var con_color = new Color(obj);	
	val = int(val);
	if (val == 0){
		con_color.setRGB("0xFFFFFF");
	}else{
		con_color.setRGB("0x00FF00");
	}
}
function getStatus(){}
this.addProperty("current_status",getStatus,setStatus);
//------------------------------------------------------------------------------------------------------------
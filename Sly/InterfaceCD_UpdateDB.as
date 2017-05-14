
Cover.tabEnabled=false;
UpdateDB.loadbar._visible=false;
function Running(obj,val){
	eval(obj+".bar")._width = (val * 500)/100;
	eval(obj+".txt").text = val + " %";
	eval(obj+".txt").autoSize = true;
}
UpdateDB.ButtonBrowseDB.onRelease = function(){
	fscommand("BrowseDB","UpdateDB")
}
UpdateDB.ButtonOk.onRelease = function(){	
//	Send2Server("client","0&&&Click||"+this,true);
	if(UpdateAva){
		UpdateDB._visible=false;
		WarningUpdate._visible=true;
		WarningUpdate.ButtonOk.onRollOver();
	}
	else{
		UpdateDB.ButtonCancel.onRelease();
	}
}
UpdateDB.ButtonCancel.onRelease = function(){
	Send2Server("client","0&&&Click||"+this,true);
	if(UpdateDB.ButtonCancel.enabled){
		UpdateDB._visible=false;
		Cover._visible=false;
		TopBar.ButtonX.onRollOver();
	}
}
UpdateDB.ButtonDownLoad.onRelease = function(){
	Send2Server("client","0&&&Click||"+this,true);
	fscommand("DownloadDatabase");
}
UpdateDB.ButtonBrowseDB.onRollOver = function(){
	SelectButton("UpdateDB.MovieBrowseDB");
}
UpdateDB.ButtonOk.onRollOver = function(){
	SelectButton("UpdateDB.MovieOk");
}
UpdateDB.ButtonCancel.onRollOver = function(){
	SelectButton("UpdateDB.MovieCancel");
}
UpdateDB.ButtonDownLoad.onRollOver = function(){
	SelectButton("UpdateDB.MovieDownLoad");
}


//======================================================================================================
// load xml from server
var stringDateUpdate = "";
function loadXmlFromServer(str_languageName){
	var ser_xml = new XML();
	var dbServer="",imageServer="";
	var xml= new readCDXML(WebSite + "/dvds/cdxml.xml",str_languageName);
//	fscommand("mb","Path = " + WebSite + "/dvds/cdxml.xml");
	xml.onLoad=function(success) {
		dbServer   = this.dbServer   ;
		imageServer= this.imageServer;
		if(success){
			ser_xml.load(WebSite+ "/dvds/countries.xml");
			ser_xml.onLoad = function(success){
				var l = new Array();
				l = ser_xml.firstChild.childNodes;
				for (var init=0; init<l.length; init++){			
					if (str_languageName == l[init].childNodes[0].nodeValue){				
						stringDateUpdate = l[init].attributes.lastDownload + "||" + l[init].attributes.lastUpdate + "||" + str_languageName +"||" + dbServer + "||" + imageServer;
						fscommand("CheckUpdateAvailable",stringDateUpdate);
						break;
					}
				}
			}
		}
	}
}

//.............Current Edit...........
//....................WarningUpdate
WarningUpdate._visible=false;
WarningUpdate.ButtonOk.onRollOver = function(){
	SelectButton("WarningUpdate.MovieOk");
}
WarningUpdate.ButtonCancel.onRollOver = function(){
	SelectButton("WarningUpdate.MovieCancel");
}
WarningUpdate.ButtonOk.onRelease = function(){
//	Send2Server("client","0&&&Click||"+this,true);
	if(WarningUpdate.ButtonOk._visible){
		WarningUpdate._visible=false;
		UpdateDB.LoadBar._visible=false;
		UpdateDB.ButtonOk.enabled=true;
		UpdateDB.ButtonCancel.enabled=true;
		UpdateDB.PatientText._visible=false;
		UpdateDB._visible=false;
		TopBar.ButtonM.onRollOver();
		Cover._visible=false;
		//fscommand("UpdateDB",stringDateUpdate);
		fscommand("UpdateDBSendToLanguagePage",stringDateUpdate);	
	}
}
WarningUpdate.ButtonCancel.onRelease = function(){
	Send2Server("client","0&&&Click||"+this,true);
	UpdateDB.ButtonOk.enabled=true;
	UpdateDB.ButtonCancel.enabled=true;
	UpdateDB.PatientText._visible=false;
	WarningUpdate._visible=false;
	UpdateDB.ButtonCancel.onRelease();
}

//...........No Update Available..................
function GetVb1(){}
var UpdateAva=false;;
function UpdateAvailable(value){
	Cover._visible=true;
	if(value=="true"){
		UpdateAva=true;
		UpdateDB._visible=true;
		UpdateDB.txt.text="Do you want to update new database ?"
		UpdateDB.ButtonOk.onRollOver();
		updateDB.txtCancel.text = "No";
		updateDB.txtOk._visible = true;
		updateDB.ButtonOk._visible = true;
		updateDB.MovieOk._visible = true;
	}
	else{
		UpdateAva=false;
		UpdateDB._visible=true;
		UpdateDB.txt.text="No new update is available at this time."
		UpdateDB.ButtonCancel.onRollOver();
		updateDB.txtCancel.text = "Ok";
		
//		UpdateDB.ButtonOk.onRollOver();
		updateDB.txtOk._visible=false;
		updateDB.ButtonOk._visible=false;
		updateDB.MovieOk._visible=false;
		
	}
}
_root.addProperty("UpdateAvailable",GetVb1,UpdateAvailable);
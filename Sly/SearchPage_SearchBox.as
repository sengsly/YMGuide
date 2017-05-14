var SearchingText = "";
function VisibleSearchingBox(value) {
	if (value) {
		var str = "";
		str = '\"'+SearchingText+'\"';
		SearchingBox.SearchFor.text = str;
		ChangeTextSearchingBox("SearchingBox.SearchFor", EngFont, UniFont, EngSize, UniSize, ChangeLan);
		SearchingBox._visible = true;
		SearchingBox.TrackFound.text = "0";
		ButtonHideMouse._visible = true;
		SearchingBox.ButtonStop.onRollOver();
	} else {
		SearchingBox._visible = false;
		ButtonHideMouse._visible = false;
		BackNormal.ButtonSearch.onRollOver();
	}
}
SearchingBox._visible = false;
SearchingBox.ButtonStop.onRollOver = function() {
	SelectButton("SearchingBox.MovieStop");
};
SearchingBox.ButtonStop.onRelease = function() {
	if (send_event("normal&&&Click||"+this+"||2", false)) {
		return;
	}
	//VisibleSearchingBox(false);
	fscommand("StopSearch");
};
function GetTrackFound(value) {
	SearchingBox.TrackFound.text = value;
}
function ShowSearchingBox(value) {
	VisibleSearchingBox(Boolean(value));
}
function ChangeTextInput(value) {
	SearchingText = value;
}
function GetVb() {
}
_root.addProperty("TrackFound", _root.GetVb, _root.GetTrackFound);
_root.addProperty("SearchFor", _root.GetVb, _root.GetSearchFor);
_root.addProperty("ShowSearchingBox", _root.GetVb, _root.ShowSearchingBox);
_root.addProperty("ShowSearchingText", _root.GetVb, _root.ChangeTextInput);

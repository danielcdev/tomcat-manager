function changeEmptyDataTable(thisDataTable, thisMessage) {
	thisDataTable.find(".dataTables_empty").html(thisMessage);
}

function addDataToDataTable(thisDataTable, thisData) {
	if (thisData == null || thisData.length <= 0) {
		changeEmptyDataTable(thisDataTable, "No data to display");
	} else {
		thisDataTable.dataTable.ext.errMode = 'throw';

		try {
			thisDataTable.dataTable().fnAddData(thisData);
		} catch (error) {
			changeEmptyDataTable(thisDataTable,
					"Error adding data to this table");
		}
	}
}

function parseListData(thisDataTable, thisData) {
	thisData = thisData.split(/\r?\n/);

	for (var i = 0; i < thisData.length; i++) {
		var toTable = thisData[i].split(":");

		if (toTable.length < 4)
			continue;

		toTable[1] = (toTable[1] == "running") ? "Yes" : "No";
		toTable[2] = (toTable[2] == "0") ? "-" : toTable[2];

		addDataToDataTable(thisDataTable, toTable);
	}
}

function fetchListData(thisDataTable, thisUrl) {
	$.ajax({
		url : thisUrl
	}).done(function(data) {
		thisDataTable.DataTable().clear();
		parseListData(thisDataTable, data);
	}).fail(function() {
		changeEmptyDataTable(thisDataTable, "Error fetching data from server");
	});
}

$.extend(true, $.fn.dataTable.defaults, {
	"bLengthChange" : false,

	language : {
		emptyTable : "<div class='loader'></div>"
	}
});
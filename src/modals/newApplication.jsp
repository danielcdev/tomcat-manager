<div class="modal" id="newApplicationModal">
	<form id="newApplicationForm" class="form-horizontal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">New application</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body">
					<div class="form-group">
						<div class="col-sm-12">
							<input type="text" class="form-control" id="newContext"
								placeholder="Context Name" autofocus />
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-12">
							<div class="custom-file">
								<input type="file" class="custom-file-input" id="newWar">
								<label class="custom-file-label" id="newFileName">Select
									WAR file</label>
							</div>
						</div>
					</div>

					<div class="modal-footer">
						<input type="submit" class="btn btn-outline-success"
							id="newUpload" value="Upload" />
						<button type="button" class="btn btn-outline-secondary"
							data-dismiss="modal">Close</button>
					</div>

				</div>
			</div>
		</div>
	</form>
</div>

<script type="text/javascript">
	$("#newWar").change(function() {
		var name = $(this).val().substr($(this).val().lastIndexOf('\\') + 1);

		$('#newFileName').html(name);
	});

	$("#newApplicationForm").submit(function(e) {
		e.preventDefault();
		$("#newUpload").prop("disabled", true);

		var file = $("#newWar")[0].files[0];

		//currentReplace.data()[1] = "<div class='loader'></div>";
		//currentReplace.data(currentReplace.data());
		$("#newApplicationModal").modal('hide');

		$.ajax({
			type : "PUT",
			url : "/manager/text/deploy?path=" + $("#newContext").val(),
			data : file,
			contentType : false,
			processData : false,
			cache : false
		}).always(function(data) {
			$("#newUpload").prop("disabled", false);
			fetchListData($("#apps"), "/manager/text/list");
		});
	});
</script>
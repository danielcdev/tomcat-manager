<div class="modal" id="replaceApplicationModal">
	<form id="replaceApplicationForm" class="form-horizontal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Replace existing application</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body">
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="war"> <label
							class="custom-file-label" id="fileName">Select WAR file</label>
					</div>
				</div>

				<div class="modal-footer">
					<input type="submit" class="btn btn-outline-success" id="upload"
						value="Upload" />
					<button type="button" class="btn btn-outline-secondary"
						data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</form>
</div>

<script type="text/javascript">
	$('#war').change(function() {
		var name = $(this).val().substr($(this).val().lastIndexOf('\\') + 1);

		$('#fileName').html(name);
	});

	$("#replaceApplicationForm").submit(function(e) {
		e.preventDefault();
		$("#upload").prop("disabled", true);

		var file = $('input:file')[0].files[0];

		currentReplace.data()[1] = "<div class='loader'></div>";
		currentReplace.data(currentReplace.data());
		$("#replaceApplicationModal").modal('hide');

		$.ajax({
			type : "GET",
			url : "/manager/text/undeploy?path=" + currentReplace.data()[0]
		}).done(function(data) {
			$.ajax({
				type : "PUT",
				url : "/manager/text/deploy?path=" + currentReplace.data()[0],
				data : file,
				contentType : false,
				processData : false,
				cache : false
			}).always(function(data) {
				$("#upload").prop("disabled", false);
				fetchListData($("#apps"), "/manager/text/list");
			});
		});
	});
</script>
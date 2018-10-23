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
						<input type="file" class="custom-file-input" id="war" name="war">
						<label class="custom-file-label" id="fileName"
							for="validatedCustomFile">Select WAR file</label>
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

		$.ajax({
			type : "GET",
			url : "/manager/text/undeploy?path=" + currentReplace[0]
		}).done(function(data) {
			$.ajax({
				type : "PUT",
				url : "/manager/text/deploy?path=" + currentReplace[0],
				data : file,
				contentType : false,
				processData : false,
				cache : false
			}).done(function(data) {
				$("#replaceApplicationModal").modal('hide');
			}).always(function(data) {
				$("#upload").prop("disabled", false);
				fetchListData($("#apps"), "/manager/text/list");
			});
		});
	});
</script>
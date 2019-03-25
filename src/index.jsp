<jsp:include page='includes/head.jsp' />

<body>

	<jsp:include page='includes/header.jsp' />

	<div class="container-fluid">
		<div class="row">
			<div class="col-10 offset-1">
				<div class="card">
					<div class="card-header">Applications</div>
					<div class="card-body">
						<button class="btn btn-outline-success" data-toggle="modal"
							data-target="#newApplicationModal">New Application</button>
						<table id="apps" class="table table-striped table-bordered"
							style="width: 100%;">
							<thead>
								<tr>
									<th>Name</th>
									<th>Running</th>
									<th>Sessions</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>

			</div>

		</div>
	</div>

	<jsp:include page='includes/footer.jsp' />

	<jsp:include page='modals/replaceApplication.jsp' />
	<jsp:include page='modals/newApplication.jsp' />

	<script type="text/javascript">
		var currentReplace;
		var apps = $('#apps')
				.DataTable(
						{
							columnDefs : [ {
								targets : 3,
								data : null,
								defaultContent : '<button class="btn btn-sm btn-outline-primary">Replace</button>'
							} ],
							columns : [ {
								data : 3
							}, {
								data : 1
							}, {
								data : 2
							} ],
							order : [ [ 1, "desc" ], [ 2, "desc" ],
									[ 0, "asc" ] ]
						});

		function refreshApplicationList() {
			fetchListData($("#apps"), "/manager/text/list");

			setTimeout(function() {
				refreshApplicationList();
			}, 20000);
		}

		$('#apps tbody').on('click', 'button', function() {
			currentReplace = apps.row($(this).parents('tr'));

			$("#replaceApplicationModal").modal('show');
		});

		$(document).ready(function() {
			refreshApplicationList();
		});
	</script>
</body>
</html>
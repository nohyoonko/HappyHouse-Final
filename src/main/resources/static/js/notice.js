$(document).ready(function () {
  $('.write-submit').click(function () {
    var title = $('#title').val();
    var content = $('#content').val();

    if (!title || !content) {
      var alert = `
            <div class="mt-2 alert alert-danger">
              <strong>Danger!</strong> 제목과 내용은 필수 작성해야합니다.
            </div>`;
    } else {
      var alert = `
          <div class="mt-2 alert alert-success">
              <strong>Success!</strong> 성공적으로 게시했습니다.
          </div>
          `;
    }
    $('#write-modal').append(alert);
  });
});

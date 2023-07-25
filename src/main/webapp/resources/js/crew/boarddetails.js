document.addEventListener("DOMContentLoaded", function() {
    var writeCommentButton = document.getElementById("writecomment");
    writeCommentButton.addEventListener("click", function() {
        var crew_comment = document.getElementById("comment").value; //댓글 내용 가져오기
        var user_id = document.getElementById("user_id").value;
        var crew_board_id = document.getElementById("crew_board_id").value;
        
        // AJAX 요청 보내기
        $.ajax({
            url: "/travel/crew/createcomment",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                "crew_comment": crew_comment,
                "user_id": user_id,
                "crew_board_id": crew_board_id
            }),
            success: function(res) {
            alert("작성이 완료되었어요!");
            getcommentlist(res);
                 // 댓글 목록 업데이트
                
            },
            error: function(err) {
                console.error("댓글 작성 실패", err);
            }
        });
    });
});

function deletecomment(board_comment_id) {
    // AJAX 요청 보내기
    if (confirm("댓글을 삭제하시겠습니까?")) {
            $.ajax({
        url: "/travel/crew/deletecomment",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
        	"board_comment_id": board_comment_id
        }),
        success: function(res) {
            alert("댓글이 삭제되었습니다.");
            getcommentlist(res);
        },
        error: function(err) {
            console.error("댓글 삭제 실패", err);
        }
    });

    }
}

function modifycomment(board_comment_id) {
    // AJAX 요청 보내기
	$.ajax({
        url: "/travel/crew/modifycomment",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
        	"board_comment_id": board_comment_id
        }),
        success: function(res) {
            alert("댓글이 삭제되었습니다.");
            getcommentlist(res);
        },
        error: function(err) {
            console.error("댓글 삭제 실패", err);
        }
    });


}

function deleteboard(crew_board_id) {
console.log(crew_board_id)
    // AJAX 요청 보내기
    if (confirm("정말 게시글을 삭제하시겠습니까?")) {
            $.ajax({
        url: "/travel/crew/deleteboard",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
        	"crew_board_id": crew_board_id
        }),
        success: function(res) {
            alert("삭제되었습니다.");
            window.location.href = res
        },
        error: function(err) {
            console.error("삭제 실패", err);
        }
    });

    }
}




function getcommentlist(res) {
document.getElementById('comment').value = ''; // 기존 댓글 목록 초기화

                let output = '';
                
                document.getElementById("commentlist").innerHTML="";
                
                for (var i = 0; i < res.length; i++) {
  					var user_nickname = res[i].commentWriter.user_nickname;
  					var commentwriterid = res[i].commentWriter.user_id;
  					var board_comment_id = res[i].crewBoardCommentDto.board_comment_id;
  					var crew_comment = res[i].crewBoardCommentDto.crew_comment;
  					var crew_comment_date = res[i].crewBoardCommentDto.crew_comment_date;
  					var session_userid = res[i].sessionuser.user_id;
  					
  					var date = new Date(crew_comment_date);
  					
            		let day = date.getDate()
            		let month = date.getMonth() + 1
            		let year = date.getFullYear()
         			let hours = date.getHours();
					let minutes = date.getMinutes();
        			
        			if (month < 10) {
					  month = '0' + month; // 1자리 수인 경우 앞에 0을 붙임
					}
					if (day < 10) {
					  day = '0' + day; // 1자리 수인 경우 앞에 0을 붙임
					}
					if (hours < 10) {
					  hours = '0' + hours; // 1자리 수인 경우 앞에 0을 붙임
					}
  					if (minutes < 10) {
					  minutes = '0' + minutes; // 1자리 수인 경우 앞에 0을 붙임
					}
  		
  						
document.getElementById("commentlist").innerHTML += `
    <div class="row mx-5 px-5">
        <div class="col commentWriter">
            <Strong>${user_nickname}</Strong>
        </div>
        <div class="col text-end">
            <c:choose>
                <c:when test="${commentwriterid == session_userid}">
					<div class="row justify-content-end">
				    	<div class="col-auto">
							<i class="bi bi-pencil icon-button" onclick="modifycomment('${board_comment_id}')" title="modify"></i>
						</div>
				        <div class="col-auto">
							<i class="bi bi-trash3 icon-button" title="remove" onclick="deletecomment('${board_comment_id}')"></i>
						</div>
					</div>
                </c:when>
                <c:otherwise>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="row mx-5 px-5 mt-3">
        <div class="comment">${crew_comment}</div>
    </div>
    <div class="row mx-5 px-5 mt-3">
        <div class="col">
            <Strong>
                ${year}-${month}-${day} ${hours}:${minutes}
            </Strong>
        </div>
        <div class="col text-end">
        </div>
    </div>
    <div class="row mx-5 px-5 mt-3">
        <hr>
    </div>`;
                }
}

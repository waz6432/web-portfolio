	function likeboard(crew_member_id, crew_board_id, post_writer) {
		console.log(crew_member_id);
		if (post_writer != crew_member_id) {
			$.ajax({
				url : "/travel/crew/likeboard",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					"crew_member_id" : crew_member_id,
					"crew_board_id" : crew_board_id
				}),
				success : function(res) {
					getpostlist(res);
				},
				error : function(err) {
					console.error("삭제 실패", err);
				}
			});
		} else {
			alert("자신의 글에는 좋아요를 할 수 없습니다.");
		}

	}

	function dislikeboard(crew_member_id, crew_board_id, post_writer) {
		console.log(crew_member_id);
		console.log(crew_board_id);
		if (post_writer != crew_member_id) {
			$.ajax({
				url : "/travel/crew/dislikeboard",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({
					"crew_member_id" : crew_member_id,
					"crew_board_id" : crew_board_id
				}),
				success : function(res) {
					getpostlist(res);
				},
				error : function(err) {
					console.error("삭제 실패", err);
				}
			});
		} else {
			alert("오류")
		}

	}

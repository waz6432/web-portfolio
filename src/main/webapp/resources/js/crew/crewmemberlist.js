function checkall() {
  var checkboxes = document.querySelectorAll('.checkboxes'); // 모든 체크박스를 선택합니다.
  var checkallCheckbox = document.getElementById('checkAll'); // 전체 선택 체크박스를 가져옵니다.
  
  // 전체 선택 체크박스의 상태에 따라 모든 체크박스를 선택하거나 해제합니다.
  for (var i = 0; i < checkboxes.length; i++) {
    checkboxes[i].checked = checkallCheckbox.checked;
  }
}

function acceptSelectedMembers() {
	  var checkboxes = document.querySelectorAll('.checkboxes'); // 모든 개별 체크박스를 선택합니다.
	  var selectedMembers = []; // 선택된 멤버들의 ID를 담을 배열
	  
	  // 개별 체크박스를 순회하면서 선택된 체크박스들을 처리합니다.
	  for (var i = 0; i < checkboxes.length; i++) {
	    var checkbox = checkboxes[i];
	    if (checkbox.checked && checkbox.id != 'checkAll') {
	      selectedMembers.push(checkbox.id.replace('checkbox', '')); // 체크박스 ID로부터 멤버 ID를 추출하여 배열에 추가합니다.
	    }
	  }
	  
	  if (selectedMembers.length === 0) {
	    alert('선택된 멤버가 없습니다.');
	    return;
	  }
	  
	  if (confirm("수락 처리하시겠습니까?")) {
		  var memberIds = selectedMembers; // 선택된 멤버 ID 배열

		  // AJAX 요청을 통해 서버로 데이터 전송
		  $.ajax({
		    type: "POST",
		    contentType: "application/json",
		    url: "/travel/crew/crewsetting/accept",
		    data: JSON.stringify({
		      "memberIds": memberIds
		    }),
		    success: function(res) {
		    	alert("수락 완료되었습니다.");

		    	getrequest(res);
		    },
		    error: function(err) {
		      console.log("실패", err);
		    }
		  });
		}

	}



function declineSelectedMembers() {
	  var checkboxes = document.querySelectorAll('.checkboxes'); // 모든 개별 체크박스를 선택합니다.
	  var selectedMembers = []; // 선택된 멤버들의 ID를 담을 배열
	  
	  // 개별 체크박스를 순회하면서 선택된 체크박스들을 처리합니다.
	  for (var i = 0; i < checkboxes.length; i++) {
	    var checkbox = checkboxes[i];
	    if (checkbox.checked && checkbox.id != 'checkAll') {
	      selectedMembers.push(checkbox.id.replace('checkbox', '')); // 체크박스 ID로부터 멤버 ID를 추출하여 배열에 추가합니다.
	    }
	  }
	  
	  if (selectedMembers.length === 0) {
	    alert('선택된 멤버가 없습니다.');
	    return;
	  }
	  
	  if (confirm("거절 처리하시겠습니까?")) {
		  var memberIds = selectedMembers; // 선택된 멤버 ID 배열

		  // AJAX 요청을 통해 서버로 데이터 전송
		  $.ajax({
		    type: "POST",
		    contentType: "application/json",
		    url: "/travel/crew/crewsetting/decline",
		    data: JSON.stringify({
		      "memberIds": memberIds
		    }),
		    success: function(res) {
		    	alert("거절 완료되었습니다.");

		    	getrequest(res);
		    },
		    error: function(err) {
		      console.log("실패", err);
		    }
		  });
		}

	}

function searchapply() {
	var searchcont = document.getElementById("appliedSearch").value;
	if(searchcont == null) {
		alert("검색어를 입력해주세요")
	} else {
		// AJAX 요청을 통해 서버로 데이터 전송
		  $.ajax({
		    type: "POST",
		    contentType: "application/json",
		    url: "/travel/crew/crewsetting/appliedsearch",
		    data: JSON.stringify({
		      "searchcont": searchcont
		    }),
		    success: function(res) {
		    	

		    	getrequest(res);
		    },
		    error: function(err) {
		      console.log("실패", err);
		    }
		  });
	}
}




function getrequest(res) {
  var table = document.getElementById("inner");
  table.innerHTML = "";
  
  var crewsize = document.getElementById("crewmembernum");
 crewsize.innerHTML = "";
 var num = res.length
 	  var spanElement = document.createElement("span");
	  spanElement.textContent = num;
crewsize.appendChild(spanElement);

  for (var i = 0; i < res.length; i++) {
    var crew_member_request_date = res[i].crewMemberDto.crew_member_request_date;
    var user_nickname = res[i].userDto.user_nickname;
    var user_email = res[i].userDto.user_email;
    var user_birth = res[i].userDto.user_birth;
    var crew_member_id = res[i].crewMemberDto.crew_member_id;
    var crew_request_intro = res[i].crewMemberDto.crew_join_request_intro;

    var gender = res[i].userDto.user_gender;
    if (gender == 'M') {
      gender = '남';
    } else if (gender == 'F') {
      gender = '여';
    } else {
      gender = '알 수 없음';
    }

    var date = new Date(crew_member_request_date);

    let day = date.getDate();
    let month = date.getMonth() + 1;
    let year = date.getFullYear();

    if (month < 10) {
      month = '0' + month;
    }

    if (day < 10) {
      day = '0' + day;
    }
    var birth = new Date(user_birth);

    let day1 = birth.getDate();
    let month1 = birth.getMonth() + 1;
    let year1 = birth.getFullYear();

    if (month1 < 10) {
      month1 = '0' + month1;
    }
    
    if (day1 < 10) {
      day1 = '0' + day1;
    }

    var row = document.createElement("tr");

    var checkboxCell = document.createElement("th");
    var checkboxInput = document.createElement("input");
    checkboxInput.setAttribute("class", "form-check-input checkboxes");
    checkboxInput.setAttribute("type", "checkbox");
    checkboxInput.setAttribute("id", "checkbox" + crew_member_id);
    checkboxCell.appendChild(checkboxInput);
    row.appendChild(checkboxCell);

    var nicknameCell = document.createElement("td");
    nicknameCell.textContent = user_nickname + "(" + user_email + ")";
    row.appendChild(nicknameCell);

    var requestDateCell = document.createElement("td");
    requestDateCell.textContent = year + "." + month + "." + day + ".";
    row.appendChild(requestDateCell);

    var birthDateCell = document.createElement("td");
    birthDateCell.textContent = year1 + "." + month1 + "." + day1 + ".";
    row.appendChild(birthDateCell);

    var genderCell = document.createElement("td");
    genderCell.textContent = gender;
    row.appendChild(genderCell);

    var introCell = document.createElement("td");
    introCell.textContent = crew_request_intro;
    row.appendChild(introCell);

    table.appendChild(row);
  }
}

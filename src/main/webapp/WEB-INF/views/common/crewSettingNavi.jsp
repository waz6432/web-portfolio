<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="theiaStickySidebar" style="position: fixed; min-width: 304px;">
	<div data-viewname="DGroupBandSideCoverView" class="sideCover">
		<div class=" flex-column flex-shrink-0 p-3">
			<div class="row">
				<div class="col align-items-center text-center">
					<a href="/travel/crew/crewhome/${crewDto.crew_domain }" class=" mb-3">
						<img src="/uploadFiles/crewFiles/crewthumbnail/${crewDto.crew_thumbnail }" width="150" height="150">
					</a>
				</div>	
			</div>
			<div class="row">
				<span class="text-center crewname">${crewDto.crew_name }</span>
			</div>

			<div class="row">
				<div class="col">멤버 ${membersize } / 20 ・ 리더 ${masterName }</div>
			</div>
				<a href="/travel/crew/crewhome/${crewDto.crew_domain }"><button class="btn btn-success form-control">홈으로</button></a>
			<hr>
			<ul class="nav nav-pills flex-column mb-auto">
				<li><a
					href="/travel/crew/crewsetting/joinrequest/${crewDto.crew_domain }"
					class="nav-link textcolourdefault" id="joinrequest"  > <svg
							class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#speedometer2"></use>
							</svg> <i class="bi bi-bookmark-star"></i>가입 신청 관리</i>
				</a></li>
				<li><a href="/travel/crew/crewsetting/members/${crewDto.crew_domain }" class="nav-link textcolourdefault" id="managewholemember">
						<svg class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#grid"></use>
							</svg> <i class="bi bi-calendar2-date">전체 멤버 관리</i>
				</a></li>
				<li><a
					href="/travel/crew/crewsetting/crewclosecheck/${crewDto.crew_domain}"
					class="nav-link textcolourdefault" id="crewclose" > <svg
							class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#table"></use>
							</svg> <i class="bi bi-people-fill"> 크루 폐쇄</i>
				</a></li>

			</ul>

		</div>
	</div>
	</div>
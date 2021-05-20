<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/template/head.jsp"%>
<script type="text/javascript">
	$(document).ready(
			function() {
				$.get("${pageContext.request.contextPath}/apt", {
					act : "sido"
				}, function(data, status) {
					$.each(data, function(index, vo) {
						$("#sido").append(
								"<option value='"+vo.sido_code+"'>"
										+ vo.sido_name + "</option>");
					});//each
				}//function
				, "json");//get
			});//ready
	$(document).ready(
			function() {
				$("#sido").change(
						function() {
							$.get("${pageContext.request.contextPath}/apt", {
								act : "gugun",
								sido : $("#sido").val()
							}, function(data, status) {
								$("#gugun").empty();
								$("#gugun").append(
										'<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#gugun").append(
											"<option value='"+vo.gugun_code+"'>"
													+ vo.gugun_name
													+ "</option>");
								});//each
							}//function
							, "json");//get
						});//change
				$("#gugun").change(
						function() {
							$.get("${pageContext.request.contextPath}/apt", {
								act : "dong",
								gugun : $("#gugun").val()
							}, function(data, status) {
								$("#dong").empty();
								$("#dong").append(
										'<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#dong").append(
											"<option value='"+vo.dong+"'>"
													+ vo.dong + "</option>");
								});//each
							}//function
							, "json");//get
						});//change
				$("#dong").change(function() {
					//
				});//change
			});//ready

	function delInterest(is) {
		var adress = $(is).data('adr');
		$.get("${pageContext.request.contextPath}/interest/delete", {
			adress : $(is).data('adr')
		}, function(data, status) {
			alert('삭제가 완료 되었습니다!');
			location.reload();
		});
	}
	function selInterest(is) {
		deleteMarkers();
		var adress = $(is).data('adr');
		var dong = adress.split(" ");
		center(dong[2]);
		$.get("${pageContext.request.contextPath}/aptrest/apt/"+ dong[2],
				function(data, status) {
					// 여기서 가져와서 지도에 찍자!
					geocode(data);
				}, "json");
	}

	function center(centerDong) {
		$.get('https://maps.googleapis.com/maps/api/geocode/json', {
			key : 'AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw',
			address : centerDong,
		}, function(data, status) {
			var officemarker = {
				coords : {
					lat : data.results[0].geometry.location.lat,
					lng : data.results[0].geometry.location.lng,
				},
				iconImage : null,
			};
			toCenter(officemarker);
		}, 'json'); //get
	}

	function geocode(jsonData) {
		let idx = 0;
		$.each(jsonData, function(index, vo) {
			let tmpLat;
			let tmpLng;
			$.get("https://maps.googleapis.com/maps/api/geocode/json", {
				key : 'AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw',
				address : vo.dong + "+" + vo.aptName + "+" + vo.jibun
			}, function(data, status) {
				var intersetmarker = {
					coords : {
						lat : data.results[0].geometry.location.lat,
						lng : data.results[0].geometry.location.lng,
					},
					iconImage : null,
					content : vo.aptName,
				};
				addMarker(intersetmarker);
			}, "json");//get
		});//each
	}
</script>
</head>
<body>
	<!--헤더 영역 시작 -->
	<%@ include file="/WEB-INF/views/template/top.jsp"%>
	<!--헤더 영역 끝-->

	<!--메인 영역 시작-->
	<section class="main-content container mt-3">
		<h1 class="text-center m-4">관심지역 목록</h1>
		<!--검색 시작-->
		<div class="row">
			<!--지도 시작-->
			<div class="col-sm-8">
				<div id="map" style="width: 100%; height: 500px; margin: auto"></div>
			</div>
			<!--아파트 정보 리스트 시작-->
			<div class="apt-list col-sm-4"
				style="overflow: scroll; height: 500px">
				<c:if test="${interestList == null}">
					<div class="no-house-card panel panel-primary">
						<div class="panel-heading"></div>
						<div class="panel-body">현재 등록된 관심지역이 없습니다!</div>
					</div>
				</c:if>
				<c:if test="${interestList != null}">
					<div class="no-house-card panel panel-primary">
						<c:forEach var="interest" items="${interestList}">
							<div class="apt-card card shadow text-center p-3 mb-3 mt-3"
								style="display: flex;">
								<h4 class="mb-3 mt-2">${interest.address}</h4>
								<div class="text-right">
									<button class="btn btn-success"
										onclick="javascript:selInterest(this);"
										data-adr="${interest.address}">지도에서 확인</button>
									<button class="btn btn-danger"
										onclick="javascript:delInterest(this);"
										data-adr="${interest.address}">삭제</button>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
		<!--지도 끝-->
		<script defer
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw&callback=initMap"></script>
		<script>
			var multi = {
				lat : 37.5012743,
				lng : 127.039585
			};
			var map;
			var markers = [];
			var infoWindow;

			function initMap() {
				map = new google.maps.Map(document.getElementById('map'), {
					center : multi,
					zoom : 15,
				});

				infoWindow = new google.maps.InfoWindow();

				const myposition = '../img/my_position.png';

				// Geolocation
				infoWindow = new google.maps.InfoWindow();
				if (navigator.geolocation) {
					navigator.geolocation.getCurrentPosition(
							function(position) {
								var pos = {
									lat : position.coords.latitude,
									lng : position.coords.longitude,
								};

								var mymarker = {
									coords : pos,
									iconImage : myposition,
									content : '현재위치',
								};
							}, function() {
								handleLocationError(true, infoWindow, map
										.getCenter());
							});
				} else {
					handleLocationError(false, infoWindow, map.getCenter());
				}
			}

			function handleLocationError(browserHasGeolocation, infoWindow, pos) {
				infoWindow.setPosition(pos);
				infoWindow
						.setContent(browserHasGeolocation ? 'Error: Geolocation 서비스 실패.'
								: 'Error: Geolocation을 지원하지 않는 브라우저.');
				infoWindow.open(map);
			}

			function clickCenter(props) {
				var moveLatLon = new google.maps.LatLng(props.coords.lat,
						props.coords.lng);
				infoWindow.close();
				infoWindow.setPosition(moveLatLon);
				infoWindow.setContent(props.content);
				infoWindow.open(map);
				map.panTo(moveLatLon);
				map.setZoom(17);
			}

			function toCenter(props) {
				var moveLatLon = new google.maps.LatLng(props.coords.lat,
						props.coords.lng);
				map.setZoom(14);
				map.panTo(moveLatLon);
			}

			function addMarker(props) {
				const marker = new google.maps.Marker({
					position : new google.maps.LatLng(
							parseFloat(props.coords.lat),
							parseFloat(props.coords.lng)),
					map : map,
					content : props.content,
				});
				//map.setCenter(marker.getPosition());
				//map.setZoom(14);

				if (props.iconImage) {
					marker.setIcon(props.iconImage);
				}

				if (props.content) {
					infoWindow = new google.maps.InfoWindow({
						content : props.content,
					});
				}

				marker.addListener('click', function() {
					map.setZoom(17);
					map.setCenter(marker.getPosition());
					infoWindow.close();
					infoWindow.setContent(marker.content);
					infoWindow.open(map, marker);
					//bounceMarker(marker);
				});

				markers.push(marker);
				setMapOnAll(map);
			}

			function bounceMarker(marker) {
				if (marker.getAnimation() !== null) {
					marker.setAnimation(null);
				} else {
					marker.setAnimation(google.maps.Animation.BOUNCE);
				}
			}

			function deleteMarkers() {
				clearMarkers();
				markers = [];
			}

			function clearMarkers() {
				setMapOnAll(null);
			}

			function setMapOnAll(map) {
				for (let i = 0; i < markers.length; i++) {
					markers[i].setMap(map);
				}
			}
		</script>
		<!--검색 끝-->

	</section>
	<!--메인 영역 끝-->

	<!--푸터 영역 시작-->
	<%@ include file="/WEB-INF/views/template/bottom.jsp"%>
	<!--푸터 영역 끝-->

	<!--회원가입 모달 -->
	<%@ include file="/WEB-INF/views/modal/joinModal.jsp"%>
	<!-- 로그인 모달 -->
	<%@ include file="/WEB-INF/views/modal/loginModal.jsp"%>
</body>
</html>
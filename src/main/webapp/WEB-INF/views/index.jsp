<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/template/head.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	$.get("${pageContext.request.contextPath}/aptrest/sido"
			,function(data, status){
				$.each(data, function(index, vo) {
					$("#sido").append("<option value='"+vo.sido_Code+"'>"+vo.sido_Name+"</option>");
				});//each
			}//function
			, "json"
		);//get
	});//ready
	$(document).ready(function(){
		$("#sido").change(function() {
			$.get("${pageContext.request.contextPath}/aptrest/gugun/"+$("#sido").val()
					,function(data, status){
						$("#gugun").empty();
						$("#gugun").append('<option value="0">선택</option>');
						$.each(data, function(index, vo) {
							$("#gugun").append("<option value='"+vo.gugun_Code+"'>"+vo.gugun_Name+"</option>");
						});//each
					}//function
					, "json"
			);//get
		});//change
		$("#gugun").change(function() {
			$.get("${pageContext.request.contextPath}/aptrest/dong/"+$("#gugun").val()

					,function(data, status){
						$("#dong").empty();
						$("#dong").append('<option value="0">선택</option>');
						$.each(data, function(index, vo) {
							$("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
						});//each
					}//function
					, "json"
			);//get
			
		});//change
		$("#dong").change(function() {
			document.location.href = "${root}/apt/mvapt?dong="+$("#dong").val();
		});//change
});//ready
</script>
</head>
<body class="main-body" style="overflow: scroll;">
	<!--헤더 영역 시작 -->
	<%@ include file="/WEB-INF/views/template/top.jsp"%>
	<!--헤더 영역 끝-->

	<!--메인 영역 시작-->
	<section class="container text-center mb-3">
		<div class="page-header mt-5 pt-5">
			<h1
				style="font-size: 100px; font-weight: bold; color: white; text-shadow: 2px 2px 2px #000; font-family: 'Anton', sans-serif;">HAPPY
				HOUSE</h1>
			<p style="font-weight: bolder;">어떤 집을 찾고 있나요?</p>
		</div>
		<!--동 검색 시작-->
		<article class="row mt-5 justify-content-center">
			<div class="form-group ml-2" id="menu1">
				<select class="form-control" name="city" id="sido">
					<option value="0">도/광역시</option>
				</select>
			</div>
			<div class="form-group ml-2" id="menu2">
				<select class="form-control" name="city" id="gugun">
					<option value="0">시/구</option>
				</select>
			</div>
			<div class="form-group ml-2" id="menu3">
				<select class="form-control" name="city" id="dong">
					<option value="0">읍/면/동</option>
				</select>
			</div>
		</article>
		<!-- 동 검색 끝-->
		<article class="row">
			<div id="map" style="width: 100%; height: 500px; margin: auto"></div>
		</article>
		<!--검색 시작-->
		<script defer
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw&callback=initMap"></script>
		<script>
			var map;
			var markers = [];
			var infoWindow;

			var locations = [];
			locations = [ [ '도봉구', 37.6658609, 127.0317674 ],
					[ '은평구', 37.6176125, 126.9227004 ],
					[ '동대문구', 37.5838012, 127.0507003 ],
					[ '동작구', 37.4965037, 126.9443073 ],
					[ '금천구', 37.4600969, 126.9001546 ],
					[ '구로구', 37.4954856, 126.858121 ],
					[ '종로구', 37.5990998, 126.9861493 ],
					[ '강북구', 37.6469954, 127.0147158 ],
					[ '중랑구', 37.5953795, 127.0939669 ],
					[ '강남구', 37.4959854, 127.0664091 ],
					[ '강서구', 37.5657617, 126.8226561 ],
					[ '중구', 37.5579452, 126.9941904 ],
					[ '강동구', 37.5492077, 127.1464824 ],
					[ '광진구', 37.5481445, 127.0857528 ],
					[ '마포구', 37.5622906, 126.9087803 ],
					[ '서초구', 37.4769528, 127.0378103 ],
					[ '성북구', 37.606991, 127.0232185 ],
					[ '노원구', 37.655264, 127.0771201 ],
					[ '송파구', 37.5048534, 127.1144822 ],
					[ '서대문구', 37.5820369, 126.9356665 ],
					[ '양천구', 37.5270616, 126.8561534 ],
					[ '영등포구', 37.520641, 126.9139242 ],
					[ '관악구', 37.4653993, 126.9438071 ],
					[ '성동구', 37.5506753, 127.0409622 ],
					[ '용산구', 37.5311008, 126.9810742 ] ];

			var lat = 37.606991
			var lng = 127.0232185
			var zoom = 11

			function initMap() {
				var opt = {
					center : {
						lat : lat,
						lng : lng
					},
					zoom : zoom,
				};
				map = new google.maps.Map(document.getElementById("map"), opt);

				var infowindow = new google.maps.InfoWindow();

				var marker, i;
				for (i = 0; i < locations.length; i++) {
					marker = new google.maps.Marker({
						id : i,
						title : locations[i][0],
						label : locations[i][0],
						position : new google.maps.LatLng(locations[i][1],
								locations[i][2]),
						map : map
					});

					google.maps.event.addListener(marker, 'click', (function(
							marker, i) {
						return function() {
							infowindow.setContent(locations[i][0]);
							infowindow.open(map, marker);
						}
					})(marker, i));
					if (marker) {
						marker.addListener('click', function() {
							console.log(this.title);
							map.setZoom(15);
							map.panTo(this.getPosition());
						});
					}
				}
			}

			function showLocation(position) {
				latitude = position.coords.latitude;
				longitude = position.coords.longitude;
				var hear = new google.maps.LatLng(latitude, longitude);
				map.panTo(hear);

			}

			function errorHandler(err) {
				if (err.code == 1) {
					alert("Error: Access is denied!");
				} else if (err.code == 2) {
					alert("Error: Position is unavailable!");
				} else if (err.code == 3) {
					alert("Erro : Time out");
				}
			}
			function getLocation() {
				if (navigator.geolocation) {
					var options = {
						timeout : 60000,
						enabledHighAccuracy : true
					};
					navigator.geolocation.getCurrentPosition(showLocation,
							errorHandler, options);
				} else {
					alert("Sorry, browser does not support geolocation!");
				}
			}
		</script>
		</div>
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

<!--메인 영역 끝-->
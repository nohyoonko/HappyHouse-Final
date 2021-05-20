<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<link rel="stylesheet" href="${root}/css/index.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap"
	rel="stylesheet" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Nanum+Gothic+Coding&display=swap"
	rel="stylesheet" />
<title>HAPPY HOUSE</title>
<style>
.overlay {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	height: 100%;
	width: 100%;
	opacity: 0;
	transition: 0.5s ease;
	background-color: #0244a7;
}

.apt-card:hover .overlay {
	opacity: 1;
}

.text {
	color: white;
	font-size: 20px;
	position: absolute;
	top: 60%;
	left: 50%;
	-webkit-transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
	text-align: center;
}
</style>
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
		dongchange($("#dong").val());
		
	});//change
	
	function dongchange(selectdong) {
		deleteMarkers();
		center(selectdong);
		$('.apt-list').children().remove();
		var card = ``;
		$.get("${pageContext.request.contextPath}/aptrest/apt/"+selectdong
				,function(data, status){
					$.each(data, function(index, vo) {
					     card += `
					            <div class="apt-card card shadow text-center pb-3 mb-3 mt-3" style="display: flex; cursor: pointer;">
					            <img
					              class="card-img-top"
					              src="http://www.ksilbo.co.kr/news/photo/202008/770672_439915_052.jpg"
					            />
					            <div>
					              <div class="apt-name mt-2 mb-2" style="font-weight: bold">`+vo.aptName+`</div>
					            </div>
					            <div class="card overlay aptclick" value="`+ vo.dong+` `+ vo.aptName +`">
					              <div class="text pt-3 container-fluid">
					                <div class="apt-name mb-2" style="font-weight: bold; font-size: small">
					                  <div class="card-header row justify-content-center">
					        
					                    <span class="aptname" style="font-size: medium">`+vo.aptName+`</span>
					                  </div>
					                  <div class="row solid pt-2" style="border-top: 2px solid #999"></div>
					                  <div class="row mb-2 justify-content-center">
					                  </div>
					                  <div class="row mb-2 justify-content-center">
					                    <i class="fa fa-hands-helping mr-2" style="color: white"></i> 거래구분
					                    <span class="badge badge-info ml-2  apt-type">'매매'</span>
					                  </div>
					                  <div class="row pb-5 justify-content-center">
					                    <i class="fa fa-calendar-alt mr-2" style="color: white"></i>
					                    <span class="apt-date">`+vo.buildYear+`년</span>
					                  </div>
					                </div>
					              </div>
					            </div>
					        </div>
					            `;
					});//each
					 $('.apt-list').append(card);
					geocode(data);
				}//function
				, "json"
		);//get
	}
	
	
	
	
});//ready



function center(centerDong) {
    $.get(
            'https://maps.googleapis.com/maps/api/geocode/json',
            {
              key: 'AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw',
              address: centerDong,
            },
            function (data, status) {
              var officemarker = {
                coords: {
                  lat: data.results[0].geometry.location.lat,
                  lng: data.results[0].geometry.location.lng,
                },
                iconImage: null,
              };
              toCenter(officemarker);
            },
            'json'
          ); //get
}

function geocode(jsonData) {
	let idx = 0;
	$.each(jsonData, function(index, vo) {
		let tmpLat;
		let tmpLng;
		$.get("https://maps.googleapis.com/maps/api/geocode/json"
				,{	key:'AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw'
					, address:vo.dong+"+"+vo.aptName+"+"+vo.jibun
				}
				, function(data, status) {
		            var officemarker = {
		                    coords: {
		                      lat: data.results[0].geometry.location.lat,
		                      lng: data.results[0].geometry.location.lng,
		                    },
		                    iconImage: null,
		                    content: vo.aptName,
		                  };
		                  console.log(officemarker);
		                  addMarker(officemarker);
				}
				, "json"
		);//get
	});//each
}

$(document).on('click', '.aptclick', function () {
    var loc = $(this).attr('value');
    var name = $(this).find('.aptname').text();
    // var index = $('.aptclick').index(this);
    console.log(loc);
    // var location = $('.aptclick').eq(index).val();
    // 몇번째 카드를 선택했는지.
    console.log('ss' + location);
    //console.log(count);

    var officeAddr = loc;

    $.get(
      'https://maps.googleapis.com/maps/api/geocode/json',
      {
        key: 'AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw',
        address: officeAddr,
      },
      function (data, status) {
        var officemarker = {
          coords: {
            lat: data.results[0].geometry.location.lat,
            lng: data.results[0].geometry.location.lng,
          },
          iconImage: null,
          content: name,
        };
        console.log(officemarker);
        clickCenter(officemarker);
      },
      'json'
    ); //get
  });



	</script>
	
	<c:if test="${selectDong != null}">
	<script type="text/javascript">
	$(document).ready(function(){
		
		function dongchange(selectdong) {
			deleteMarkers();
			center(selectdong);
			$('.apt-list').children().remove();
			var card = ``;
			$.get("${pageContext.request.contextPath}/aptrest/apt/"+selectdong
					,function(data, status){
						$.each(data, function(index, vo) {
						     card += `
						            <div class="apt-card card shadow text-center pb-3 mb-3 mt-3" style="display: flex; cursor: pointer;">
						            <img
						              class="card-img-top"
						              src="http://www.ksilbo.co.kr/news/photo/202008/770672_439915_052.jpg"
						            />
						            <div>
						              <div class="apt-name mt-2 mb-2" style="font-weight: bold">`+vo.aptName+`</div>
						            </div>
						            <div class="card overlay aptclick" value="`+ vo.dong+` `+ vo.aptName +`">
						              <div class="text pt-3 container-fluid">
						                <div class="apt-name mb-2" style="font-weight: bold; font-size: small">
						                  <div class="card-header row justify-content-center">
						        
						                    <span class="aptname" style="font-size: medium">`+vo.aptName+`</span>
						                  </div>
						                  <div class="row solid pt-2" style="border-top: 2px solid #999"></div>
						                  <div class="row mb-2 justify-content-center">
						                  </div>
						                  <div class="row mb-2 justify-content-center">
						                    <i class="fa fa-hands-helping mr-2" style="color: white"></i> 거래구분
						                    <span class="badge badge-info ml-2  apt-type">'매매'</span>
						                  </div>
						                  <div class="row pb-5 justify-content-center">
						                    <i class="fa fa-calendar-alt mr-2" style="color: white"></i>
						                    <span class="apt-date">`+vo.buildYear+`년</span>
						                  </div>
						                </div>
						              </div>
						            </div>
						        </div>
						            `;
						});//each
						 $('.apt-list').append(card);
						geocode(data);
					}//function
					, "json"
			);//get
		}
		
		var dong = '${selectDong}';
		dongchange(dong);
	});//ready
	</script>
</c:if>

</head>
<body>
	<!--헤더 영역 시작 -->
	<%@ include file="/WEB-INF/views/template/top.jsp"%>
	<!--헤더 영역 끝-->

	<!--메인 영역 시작-->
	<section class="main-content container mt-3">
		<!--동 검색 시작-->
		<article class="row mt-3 justify-content-end">
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

		<!--지도 시작-->
		<div class="row">
			<div class="col-sm-8">
				<div id="map" style="width: 100%; height: 500px; margin: auto"></div>
				<script defer
					src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw&callback=initMap"></script>
				<script>
				
            var multi = { lat: 37.5012743, lng: 127.039585 };
            var map;
            var markers = [];
            var infoWindow;

            function initMap() {
              map = new google.maps.Map(document.getElementById('map'), {
                center: multi,
                zoom: 15,
              });

              infoWindow = new google.maps.InfoWindow();

              const myposition = '../img/my_position.png';

              // Geolocation
              infoWindow = new google.maps.InfoWindow();
              if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                  function (position) {
                    var pos = {
                      lat: position.coords.latitude,
                      lng: position.coords.longitude,
                    };

                    var mymarker = {
                      coords: pos,
                      iconImage: myposition,
                      content: '현재위치',
                    };
                  },
                  function () {
                    handleLocationError(true, infoWindow, map.getCenter());
                  }
                );
              } else {
                handleLocationError(false, infoWindow, map.getCenter());
              }
            }

            function handleLocationError(browserHasGeolocation, infoWindow, pos) {
              infoWindow.setPosition(pos);
              infoWindow.setContent(
                browserHasGeolocation ? 'Error: Geolocation 서비스 실패.' : 'Error: Geolocation을 지원하지 않는 브라우저.'
              );
              infoWindow.open(map);
            }

            function clickCenter(props) {
              var moveLatLon = new google.maps.LatLng(props.coords.lat, props.coords.lng);
              infoWindow.close();
              infoWindow.setPosition(moveLatLon);
              infoWindow.setContent(props.content);
              infoWindow.open(map);
              map.panTo(moveLatLon);
              map.setZoom(17);
            }

            function toCenter(props) {
              var moveLatLon = new google.maps.LatLng(props.coords.lat, props.coords.lng);
              map.setZoom(14);
              map.panTo(moveLatLon);
            }

            function addMarker(props) {
              const marker = new google.maps.Marker({
                position: new google.maps.LatLng(parseFloat(props.coords.lat), parseFloat(props.coords.lng)),
                map: map,
                content: props.content,
              });
              //map.setCenter(marker.getPosition());
              //map.setZoom(14);

              if (props.iconImage) {
                marker.setIcon(props.iconImage);
              }

              if (props.content) {
                infoWindow = new google.maps.InfoWindow({
                  content: props.content,
                });
              }

              marker.addListener('click', function () {
                makelist(marker.content);
                map.setZoom(17);
                map.setCenter(marker.getPosition());
                infoWindow.close();
                infoWindow.setContent(marker.content);
                infoWindow.open(map, marker);
                //bounceMarker(marker);
              });

              function makelist(content) {
                console.log('content :: ' + content);
                var newlist = ``;
                $('.apt-info-list').empty();
            	$.get("${pageContext.request.contextPath}/aptrest/dealInfo/" + content
            			,function(data, status){
        					$.each(data, function(index, vo) {
        						console.log(vo);
        						newlist += `
        							  <tr>
        		                      <td>`+vo.aptName+`</td>
        		                      <td>`+vo.dealAmount+`</td>
        		                      <td>`+vo.area+`</td>
        		                      <td><span class="badge badge-info ml-2">'매매'</span></td>
        		                      <td>`+vo.dealYear+`-`+vo.dealMonth+`-`+vo.dealDay+`</td>
        		                    </tr>`;
        					});//each
                            $('.apt-info-list').append(newlist);
            			}//function
            			, "json"
            		);//get

              }
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
			</div>
			<!--지도 끝-->

			<!--아파트 정보 리스트 시작-->
			<div class="apt-list col-sm-4"
				style="overflow: scroll; height: 500px">
				<!-- <div style="display: none">현재 존재하는 집이 없습니다.</div> -->
				<div class="no-house-card panel panel-primary" style="display: none">
					<div class="panel-heading"></div>
					<div class="panel-body">현재 존재하는 집이 없습니다!</div>
				</div>
			</div>
		</div>
		<!--아파트 정보 리스트 끝-->

		<article class="mt-5 mb-5">
			<table class="table table-hover card-list">
				<thead>
					<tr>
						<th>아파트 이름</th>
						<th>거래금액</th>
						<th>전용면적</th>
						<th>거래구분</th>
						<th>날짜</th>
					</tr>
				</thead>
				<tbody class="apt-info-list"></tbody>
			</table>
		</article>
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
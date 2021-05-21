<template>
  <article class="row">
		<div id="index-map">
			<div id="map" style="width:60vw;height:40vh">
			</div>
    </div>
    </article>
</template>

<script>
export default {
  name:'indexmap',
  props: {
    markerlocs: {type: Array},
  },
  data() {
    return {
    
    };
  },
	watch: {
		markerlocs: function() {
			console.log("index map is watching!");
		}
	},
  mounted() {
		console.log("index-map: "+this.markerlocs);
    if (window.kakao && window.kakao.maps) {
      this.initMap()
    } else {
      const script = document.createElement('script')
			/*global kakao*/ 
      script.onload = () => kakao.maps.load(this.initMap);
      script.src = 'http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=b80b9f0e805429d445e5a1dd888a722f&libraries=services'
      document.head.appendChild(script)
    }
  },
	updated(){
		this.initMap();
	},
  methods: {
		initMap () {
					var mapContainer = document.getElementById('map')
					var options = {
						center: new kakao.maps.LatLng(36.331522, 127.030600),
						level: 3
					}
					var points = [];
					var cnt = 0;
					var map = new kakao.maps.Map(mapContainer, options)
					var geocoder = new window.kakao.maps.services.Geocoder()
					for(var i = 0; i < this.markerlocs.length; i++){
						console.log(this.markerlocs[i]);
					geocoder.addressSearch(this.markerlocs[i], function (result, status) {
							if (status === kakao.maps.services.Status.OK) {
								var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
								points[cnt++] = coords;
								
								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker({
									map: map,
									position: coords
								});

											// 커스텀 오버레이에 표시할 컨텐츠 입니다
											// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
											// 별도의 이벤트 메소드를 제공하지 않습니다
											var content = '<div class="wrap"><div class="info">';
											content += '<div class="title">dd</div>';
											content += '<div class="body">';
											content += '<div class="desc">';
											content += '<div class="ellipsis"><strong>건축년도</strong> : dd년</div>';
											content += '<div class="ellipsis"><strong>주소</strong> : dd </div>';
											content += '</div></div></div></div>';

											// 마커 위에 커스텀오버레이를 표시합니다
											// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
											var overlay = new kakao.maps.CustomOverlay({
												content: content,
												map: map,
												position: marker.getPosition(),
											});
											overlay.setVisible(false);

											// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
											kakao.maps.event.addListener(marker, 'click', function () {
												if (overlay.getVisible() == true) {
													overlay.setVisible(false);
												} else {
													overlay.setVisible(true);
												}
											});

											// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
											map.setCenter(coords);
										}
										// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
										var bounds = new kakao.maps.LatLngBounds();
										// LatLngBounds 객체에 좌표를 추가합니다
										var j;
										for (j = 0; j < cnt; j++) {
											bounds.extend(points[j]);
										}
										// LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
										// 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
										map.setBounds(bounds);
									});//addressSearch
					}
				}
			}
}
</script>

<style>
</style>
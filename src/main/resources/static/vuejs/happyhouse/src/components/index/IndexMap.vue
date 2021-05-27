<template>
  <b-row id="index-map" class="justify-content-center">
		<b-col id="map" class="mb-5 ml-2 mr-2" style="width:80vw;height:50vh"></b-col>
  </b-row>
</template>

<script>
import { mapState } from 'vuex';
const aptStore = 'aptStore'

export default {
  name:'indexmap',
  props: {
    //markerlocs: {type: Array, required: true,},
  },
	computed: {
		markerlocs: {
      get() {
        return this.$store.getters["aptStore/get_markerlocs"];
      },
      set(value) {
        this.$store.commit("aptStore/ADD_MARKERLOCS", value);
      },
		},
	},
  mounted() {
    if (window.kakao && window.kakao.maps) {
      this.initMap()
    } else {
      const script = document.createElement('script')
      script.onload = () => kakao.maps.load(this.initMap);
      script.src = 'http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=b80b9f0e805429d445e5a1dd888a722f&libraries=services'
      document.head.appendChild(script)
    }
  },
	created() {
		this.$store.commit("aptStore/ADD_MARKERLOCS", []);
	},
	watch:{
		markerlocs: function(){
			if(this.markerlocs.length != 0)
				this.initMap();
		}
	},
  methods: {
		initMap () {
					var mapContainer = document.getElementById('map')
					var options = {
						center: new kakao.maps.LatLng(37.5642135, 127.0016985),
						level: 8
					}
					var points = [];
					var cnt = 0;
					var map = new kakao.maps.Map(mapContainer, options)
					var geocoder = new window.kakao.maps.services.Geocoder()
					var imageSrc = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHhtbG5zOnN2Z2pzPSJodHRwOi8vc3ZnanMuY29tL3N2Z2pzIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgeD0iMCIgeT0iMCIgdmlld0JveD0iMCAwIDUxMiA1MTIiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMiA1MTIiIHhtbDpzcGFjZT0icHJlc2VydmUiIGNsYXNzPSIiPjxnPgo8cG9seWdvbiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHN0eWxlPSIiIHBvaW50cz0iNDMyLjEwNiwyNTAuNTM0IDQzMi4xMDYsNDcwLjAyMSAyOTYuNTc4LDQ3MC4wMjEgMjk2LjU3OCwzMzYuOTc1IDIyMS4zOTksMzM2Ljk3NSAgIDIyMS4zOTksNDcwLjAyMSA3OS44OTQsNDcwLjAyMSA3OS44OTQsMjUwLjUzNCAyNTYsMTE1LjA3NSAiIGZpbGw9IiM1ZWUxZjUiIGRhdGEtb3JpZ2luYWw9IiNmZmI3NGYiIGNsYXNzPSIiPjwvcG9seWdvbj4KPHBhdGggeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBzdHlsZT0iIiBkPSJNNDM5LjQ4NSwxODMuMTM1VjkwLjMwNmgtNzQuMTY3djM1Ljc3MkwyNTYsNDEuOTc5TDAsMjM4LjkybDUzLjYzMyw2OS43MTJMMjU2LDE1Mi45NTkgIGwyMDIuMzY3LDE1NS42NzJMNTEyLDIzOC45Mkw0MzkuNDg1LDE4My4xMzV6IiBmaWxsPSIjMDBiNGNmIiBkYXRhLW9yaWdpbmFsPSIjZmY3ZDNjIiBjbGFzcz0iIj48L3BhdGg+Cjxwb2x5Z29uIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgc3R5bGU9IiIgcG9pbnRzPSI0MzIuMTA2LDI1MC41MzQgNDMyLjEwNiw0NzAuMDIxIDI5Ni41NzgsNDcwLjAyMSAyOTYuNTc4LDMzNi45NzUgMjU2LDMzNi45NzUgMjU2LDExNS4wNzUgICAiIGZpbGw9IiMyN2NhZTMiIGRhdGEtb3JpZ2luYWw9IiNmZjlhMDAiIGNsYXNzPSIiPjwvcG9seWdvbj4KPHBvbHlnb24geG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBzdHlsZT0iIiBwb2ludHM9IjUxMiwyMzguOTIgNDU4LjM2NywzMDguNjMyIDI1NiwxNTIuOTU5IDI1Niw0MS45NzkgMzY1LjMxOCwxMjYuMDc4IDM2NS4zMTgsOTAuMzA2ICAgNDM5LjQ4NSw5MC4zMDYgNDM5LjQ4NSwxODMuMTM1ICIgZmlsbD0iIzAwOTdhZSIgZGF0YS1vcmlnaW5hbD0iI2ZmNGUxOSIgY2xhc3M9IiI+PC9wb2x5Z29uPgo8ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8L2c+CjxnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjwvZz4KPGcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPC9nPgo8ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8L2c+CjxnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjwvZz4KPGcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPC9nPgo8ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8L2c+CjxnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjwvZz4KPGcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPC9nPgo8ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8L2c+CjxnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjwvZz4KPGcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPC9nPgo8ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8L2c+CjxnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjwvZz4KPGcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPC9nPgo8L2c+PC9zdmc+",  
						imageSize = new kakao.maps.Size(32, 33), // 마커이미지의 크기입니다
						imageOption = {offset: new kakao.maps.Point(16, 16)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
							
				// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
					var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

					for(var i = 0; i < this.markerlocs.length; i++){
						const text = this.markerlocs[i].addrtext;
						geocoder.addressSearch(this.markerlocs[i].addr, (result, status) => {
							if (status === kakao.maps.services.Status.OK) {
								var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
								points[cnt++] = coords;
								
								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker({
									map: map,
									position: coords,
									image: markerImage
								});

											// 커스텀 오버레이에 표시할 컨텐츠 입니다
											// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
											// 별도의 이벤트 메소드를 제공하지 않습니다
											var content = '<div class ="label"><span class="left"></span><span class="center">'+text+'</span><span class="right"></span></div>';
											// 마커 위에 커스텀오버레이를 표시합니다
											// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
											var overlay = new kakao.maps.CustomOverlay({
												content: content,
												map: map,
												position: marker.getPosition(),
												xAnchor: 0.5,
												yAnchor: 0.3,
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
.label {margin-bottom: 96px;}
.label * {display: inline-block;vertical-align: top;}
.label .left {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 24px;overflow: hidden;vertical-align: top;width: 7px;}
.label .center {background: url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 24px;font-size: 12px;line-height: 24px;}
.label .right {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 24px;overflow: hidden;width: 6px;}
</style>
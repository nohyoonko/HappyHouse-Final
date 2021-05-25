<template>
  <b-row id="index-map" class="justify-content-center">
    <b-col
      id="map"
      class="mb-5"
      style="width: 80vw; height: 50vh"
    ></b-col>

    <!-- <ul id="category">
        <li id="BK9" data-order="0">
          <span class="category_bg bank"></span>
          은행
        </li>
        <li id="MT1" data-order="1">
          <span class="category_bg mart"></span>
          마트
        </li>
        <li id="PM9" data-order="2">
          <span class="category_bg pharmacy"></span>
          약국
        </li>
        <li id="OL7" data-order="3">
          <span class="category_bg oil"></span>
          주유소
        </li>
        <li id="CE7" data-order="4">
          <span class="category_bg cafe"></span>
          카페
        </li>
        <li id="CS2" data-order="5">
          <span class="category_bg store"></span>
          편의점
        </li>
      </ul> -->
  </b-row>
</template>

<script>
import { mapState } from "vuex";
const aptStore = "aptStore";

export default {
  name: "aptmap",
  props: {
    //markerlocs: {type: Array, required: true,},
  },
  computed: {
    ...mapState(aptStore, ["markerlocs"]),
  },
  mounted() {
    if (window.kakao && window.kakao.maps) {
      this.initMap();
    } else {
      const script = document.createElement("script");
      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        "http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=b80b9f0e805429d445e5a1dd888a722f&libraries=services";
      document.head.appendChild(script);
    }
  },
  watch: {
    markerlocs: function () {
      //alert("watching markerlocs");
      this.initMap();
    },
  },
  methods: {
    initMap() {
      var mapContainer = document.getElementById("map");

      var options = {
        center: new kakao.maps.LatLng(37.5642135, 127.0016985),
        level: 8,
      };
      
      var points = [];
      var cnt = 0;
      var map = new kakao.maps.Map(mapContainer, options);
      var geocoder = new window.kakao.maps.services.Geocoder();
      for (var i = 0; i < this.markerlocs.length; i++) {
        const text = this.markerlocs[i].addrtext;
        geocoder.addressSearch(this.markerlocs[i].addr, (result, status) => {
          if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            points[cnt++] = coords;

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
              map: map,
              position: coords,
            });

            // 커스텀 오버레이에 표시할 컨텐츠 입니다
            // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
            // 별도의 이벤트 메소드를 제공하지 않습니다
            var content =
              '<div class ="label"><span class="left"></span><span class="center">' +
              text +
              '</span><span class="right"></span></div>';
            // 마커 위에 커스텀오버레이를 표시합니다
            // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
            var overlay = new kakao.maps.CustomOverlay({
              content: content,
              map: map,
              position: marker.getPosition(),
            });
            overlay.setVisible(false);

            // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
            kakao.maps.event.addListener(marker, "click", function () {
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
        }); //addressSearch
      }
      //RangeSlider();
    }, //initMap
  },
};
</script>

<style>
.label {
  margin-bottom: 96px;
}
.label * {
  display: inline-block;
  vertical-align: top;
}
.label .left {
  background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png")
    no-repeat;
  display: inline-block;
  height: 24px;
  overflow: hidden;
  vertical-align: top;
  width: 7px;
}
.label .center {
  background: url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png)
    repeat-x;
  display: inline-block;
  height: 24px;
  font-size: 12px;
  line-height: 24px;
}
.label .right {
  background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px
    0 no-repeat;
  display: inline-block;
  height: 24px;
  overflow: hidden;
  width: 6px;
}
</style>

$(document).ready(function () {
  let area_code = localStorage.getItem('areacode');
  let aptdeal = [];
  let aptrent = [];
  let set = new Set();
  if (area_code) {
    console.log('들어와' + area_code);
    $('.no-house-card').css('display', 'none');
    aptdeal = [];
    aptrent = [];
    $('.apt-list').children().remove();
    getAptDealInfo(area_code);
    getAptRentInfo(area_code);
  } else {
    $('.no-house-card').css('display', '');
  }

  var gu = {
    서울특별시: ['광진구', '종로구'],
    경기도: ['성남시 분당구', '수원시 팔달구'],
  };

  var dong = {
    광진구: ['광장동', '구의동'],
    종로구: ['종로1가', '종로2가'],
    '성남시 분당구': ['서현동', '이매동'],
    '수원시 팔달구': ['인계동', '우만동'],
  };

  var code = {
    '서울특별시 광진구 광장동': ['11215', '10400'],
    '서울특별시 광진구 구의동': ['11215', '10300'],
    '서울특별시 종로구 종로1가': ['11110', '12600'],
    '서울특별시 종로구 종로2가': ['11110', '13800'],
    '경기도 성남시 분당구 서현동': ['41135', '10500'],
    '경기도 성남시 분당구 이매동': ['41135', '10600'],
    '경기도 수원시 팔달구 인계동': ['41115', '14100'],
    '경기도 수원시 팔달구 우만동': ['41115', '14000'],
  };

  //   console.log(si);
  console.log(gu);
  console.log(dong);

  /*동으로 검색 시작*/
  $('#menu1').click(function () {
    var selected_si = $('#menu1 option:selected').val();
    console.log(selected_si);
    var options = $('#menu2 option');
    options.each(function (index, item) {
      if (index >= 1) {
        $(this).remove();
      }
    });
    if (selected_si === 'all') {
      return;
    } else {
      var items = ``;
      $.each(gu[selected_si], function (index, item) {
        items += `<option value="${item}">${item}</option>`;
      });
      $('#menu2 select').append(items);
    }
  });

  $('#menu2').on('change', function () {
    var selected_gu = $('#menu2 option:selected').val();
    console.log(selected_gu);
    var options = $('#menu3 option');
    options.each(function (index, item) {
      if (index >= 1) {
        $(this).remove();
      }
    });
    if (selected_gu === 'all') {
      return;
    } else {
      var items = ``;
      $.each(dong[selected_gu], function (index, item) {
        items += `<option value="${item}">${item}</option>`;
      });
      $('#menu3 select').append(items);
    }
  });

  $('#menu3').on('change', function () {
    var selected_si = $('#menu1 option:selected').val();
    var selected_gu = $('#menu2 option:selected').val();
    var selected_dong = $('#menu option:selected').val();
    console.log(selected_dong);

    //체크
    if (selected_si == 'all' || selected_gu == 'all' || selected_dong === 'all') {
      console.log('못뽑아!');
      return;
    } else {
      var area = $('#menu1 option:selected').val() + ' ' + $('#menu2 option:selected').val() + ' ' + $('#menu3 option:selected').val();
      var area_code = code[area];
      console.log('법정코드' + area_code);
      console.log(area_code[0]);
      aptdeal = [];
      aptrent = [];
      $('.apt-list').children().remove();

      set = new Set();
      getAptDealInfo(area_code[0]);
      getAptRentInfo(area_code[0]);
    }
  });

  function getAptDealInfo(area_code) {
    var url = 'http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev'; /*URL*/
    var queryParams =
      '?' +
      encodeURIComponent('ServiceKey') +
      '=' +
      'x3CLCnEsFre5kR5xAJlqo9Qg0s4kV99btuVWWFpTd7Zm9N1Dj8AvKXtZqNNpzQ%2BkfA5SD5zx4sWdc3tuYekhKg%3D%3D'; /*Service Key*/
    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /**/
    queryParams += '&' + encodeURIComponent('LAWD_CD') + '=' + encodeURIComponent(area_code); /**/
    queryParams += '&' + encodeURIComponent('DEAL_YMD') + '=' + encodeURIComponent('201512'); /**/
    $.ajax({
      url: url + queryParams,
      method: 'GET',
      success: function (res) {
        console.log('성공');

        console.log(res);
        makeaptdeal(res);
        makeCard(aptdeal);
      },
      error: function (xhr, status, msg) {
        console.log('상태값 : ' + status + ' Http에러메시지 : ' + msg);
      },
    });
  }

  /*동으로 검색 끝 */

  /**아파트 매매 거래  */
  function makeaptdeal(data) {
    $(data)
      .find('item')
      .each(function (index, item) {
        var aptInfo = {};
        if (aptdeal.length == 5) {
          return;
        }

        aptInfo['아파트'] = $(item).find('아파트').text().trim();
        aptInfo['거래금액'] = $(item).find('거래금액').text().trim();
        aptInfo['전용면적'] = $(item).find('전용면적').text().trim();
        aptInfo['거래구분'] = '매매';
        aptInfo['년'] = $(item).find('년').text().trim();
        aptInfo['월'] = $(item).find('월').text().trim();
        aptInfo['일'] = $(item).find('일').text().trim();
        aptInfo['월'] = $(item).find('월').text().trim();
        var addr = $(item).find('법정동').text().trim() + ' ';
        addr += $(item).find('지번').text().trim();
        aptInfo['addr'] = addr;

        aptdeal.push(aptInfo);
        console.log(aptInfo);
      });
  }

  /**아파트 전월세 시작 */

  function getAptRentInfo(area_code) {
    console.log('아파트 전월세 시작!!!!!');
    var url = 'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptRent'; /*URL*/
    var queryParams =
      '?' +
      encodeURIComponent('ServiceKey') +
      '=' +
      'x3CLCnEsFre5kR5xAJlqo9Qg0s4kV99btuVWWFpTd7Zm9N1Dj8AvKXtZqNNpzQ%2BkfA5SD5zx4sWdc3tuYekhKg%3D%3D'; /*Service Key*/
    queryParams += '&' + encodeURIComponent('LAWD_CD') + '=' + encodeURIComponent(area_code); /**/
    queryParams += '&' + encodeURIComponent('DEAL_YMD') + '=' + encodeURIComponent('201512'); /**/
    $.ajax({
      url: url + queryParams,
      method: 'GET',
      success: function (res) {
        console.log('성공');
        console.log(res);

        makeaptrent(res);
        makeCard(aptrent);
      },
      error: function (xhr, status, msg) {
        console.log('상태값 : ' + status + ' Http에러메시지 : ' + msg);
      },
    });
  }

  function makeaptrent(data) {
    $(data)
      .find('item')
      .each(function (index, item) {
        var aptInfo = {};
        if (aptrent.length == 5) {
          return;
        }

        aptInfo['아파트'] = $(item).find('아파트').text().trim();
        aptInfo['거래금액'] = $(item).find('월세금액').text().trim();
        aptInfo['전용면적'] = $(item).find('전용면적').text().trim();
        aptInfo['거래구분'] = '전/월세';
        aptInfo['년'] = $(item).find('년').text().trim();
        aptInfo['월'] = $(item).find('월').text().trim();
        aptInfo['일'] = $(item).find('일').text().trim();
        aptInfo['월'] = $(item).find('월').text().trim();
        var addr = $(item).find('법정동').text().trim() + ' ';
        addr += $(item).find('지번').text().trim();
        aptInfo['addr'] = addr;

        aptrent.push(aptInfo);
        console.log(aptInfo);
      });
  }

  function makeCard(arr) {
    var card = ``;
    $.each(arr, function (index, item) {
      var date = item['년'] + '-' + item['월'] + '-' + item['일'];
      card += `
            <div class="apt-card card shadow text-center pb-3 mb-3 mt-3" style="display: flex; cursor: pointer;">
            <img
              class="card-img-top"
              src="http://www.ksilbo.co.kr/news/photo/202008/770672_439915_052.jpg"
            />
            <div>
              <div class="apt-name mt-2 mb-2" style="font-weight: bold">${item['아파트']}</div>
            </div>
            <div class="card overlay aptclick" value="${item['addr']}">
              <div class="text pt-3 container-fluid">
                <div class="apt-name mb-2" style="font-weight: bold; font-size: small">
                  <div class="card-header row justify-content-center">
        
                    <span class="aptname" style="font-size: medium">${item['아파트']}</span>
                  </div>
                  <div class="row solid pt-2" style="border-top: 2px solid #999"></div>
                  <div class="row mb-2 justify-content-center">
                    <i class="fa fa-coins mr-2" style="color: white"></i> 거래금액<span class="apt-cost"
                      >${item['거래금액']}</span
                    >
                  </div>
                  <div class="row mb-2 justify-content-center">
                    <i class="fa fa-chart-area mr-2" style="color: white"></i> 전용면적
                    <span class="apt-area">${item['전용면적']}</span>
                  </div>
                  <div class="row mb-2 justify-content-center">
                    <i class="fa fa-hands-helping mr-2" style="color: white"></i> 거래구분
                    <span class="badge badge-info ml-2  apt-type">${item['거래구분']}</span>
                  </div>
                  <div class="row pb-5 justify-content-center">
                    <i class="fa fa-calendar-alt mr-2" style="color: white"></i>
                    <span class="apt-date">${date}</span>
                  </div>
                </div>
              </div>
            </div>
        </div>
            `;
    });

    $('.apt-list').append(card);
    AddMarker(arr);
  }

  function AddMarker(arr) {
    deleteMarkers();

    $.each(arr, function (index, item) {
      if (index == 0) {
        var center = item['addr'];
        // 맵 센터로
        $.get(
          'https://maps.googleapis.com/maps/api/geocode/json',
          {
            key: 'AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw',
            address: center,
          },
          function (data, status) {
            var officemarker = {
              coords: {
                lat: data.results[0].geometry.location.lat,
                lng: data.results[0].geometry.location.lng,
              },
              iconImage: null,
              content: item['아파트'],
            };
            toCenter(officemarker);
          },
          'json'
        ); //get
      }

      if (!set.has(item['아파트'])) {
        set.add(item['아파트']);
        var addr = item['addr'];
        $.get(
          'https://maps.googleapis.com/maps/api/geocode/json',
          {
            key: 'AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw',
            address: addr,
          },
          function (data, status) {
            var officemarker = {
              coords: {
                lat: data.results[0].geometry.location.lat,
                lng: data.results[0].geometry.location.lng,
              },
              iconImage: null,
              content: item['아파트'],
            };
            console.log(officemarker);
            addMarker(officemarker);
          },
          'json'
        ); //get
      }
    });
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
});

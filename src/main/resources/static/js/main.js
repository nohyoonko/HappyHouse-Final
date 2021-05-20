$(document).ready(function () {
  let aptdeal = [];
  let aptrent = [];
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

  // var code = {
  //   '서울특별시 광진구 광장동': ['11215', '10400'],
  //   '서울특별시 광진구 구의동': ['11215', '10300'],
  //   '서울특별시 종로구 종로1가': ['11110', '12600'],
  //   '서울특별시 종로구 종로2가': ['11110', '13800'],
  //   '경기도 성남시 분당구 서현동': ['41135', '10500'],
  //   '경기도 성남시 분당구 이매동': ['41135', '10600'],
  //   '경기도 수원시 팔달구 인계동': ['41115', '14100'],
  //   '경기도 수원시 팔달구 우만동': ['41115', '14000'],
  // };
  var code = {
    '서울특별시 광진구 광장동': ['11215'],
    '서울특별시 광진구 구의동': ['11215'],
    '서울특별시 종로구 종로1가': ['11110'],
    '서울특별시 종로구 종로2가': ['11110'],
    '경기도 성남시 분당구 서현동': ['41135'],
    '경기도 성남시 분당구 이매동': ['41135'],
    '경기도 수원시 팔달구 인계동': ['41115'],
    '경기도 수원시 팔달구 우만동': ['41115'],
  };

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

    //체크
    if (selected_si == 'all' || selected_gu == 'all' || selected_dong === 'all') {
      console.log('못뽑아!');
      return;
    } else {
      var area = $('#menu1 option:selected').val() + ' ' + $('#menu2 option:selected').val() + ' ' + $('#menu3 option:selected').val();
      var area_code = code[area];
      localStorage.setItem('areacode', area_code);
      location.href = '../aptsearch.html';
    }
  });
});

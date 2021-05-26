const request = require('request');
const cheerio = require('cheerio');

const newsStore = {
  namespaced: true,
  state: {
    news: [],
  },
  mutations: {
    GETNEWS(state, data) {
      state.news = data;
    },
  },
  actions: {
    getNews({ commit }) {
      request(
        {
          url: 'https://search.naver.com/search.naver?where=news&query=%EC%95%84%ED%8C%8C%ED%8A%B8%EB%A7%A4%EB%A7%A4&sm=tab_opt&sort=1',
          method: 'GET',
        },
        (error, response, body) => {
          if (error) {
            console.error(error);
            return;
          }
          if (response.statusCode === 200) {
            const $ = cheerio.load(body);
            const result = [];
            for (let i = 1; i <= 5; i++) {
              const news_div = $('#sp_nws' + i + ' > div > div > a.news_tit').toArray();
              const desc_div = $('#sp_nws' + i + ' > div > div').toArray();
              const url = $(news_div).attr('href');
              const title = $(news_div).attr('title');
              const summary = $(desc_div).find('a').last().text();

              result.push({
                url,
                title,
                summary,
              });
            }
            commit('GETNEWS', result);
          }
        }
      );
    },
  },
};

export default newsStore;

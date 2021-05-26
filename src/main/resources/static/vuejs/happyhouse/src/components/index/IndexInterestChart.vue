<script>
//Importing Bar class from the vue-chartjs wrapper
import { Bar } from 'vue-chartjs';
import { mapActions, mapState } from 'vuex';
const interestStore = 'interestStore';
//Exporting this so it can be used in other components
export default {
  extends: Bar,
  data() {
    return {
      datacollection: {
        //Data to be represented on x-axis
        labels: ['January', 'February', 'March', 'April', 'May'],
        datasets: [
          {
            label: '관심지역 선호도',
            backgroundColor: '#17a2b8',
            pointBackgroundColor: 'white',
            borderWidth: 1,
            pointBorderColor: '#17a2b8',
            //Data to be represented on y-axis
            data: [40, 20, 30, 50, 90],
          },
        ],
      },
      //Chart.js options that controls the appearance of the chart
      options: {
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true,
              },
              gridLines: {
                display: true,
              },
            },
          ],
          xAxes: [
            {
              gridLines: {
                display: false,
              },
            },
          ],
        },
        onClick: function (point, event) {
          if (event.length <= 0) return;
          console.log(event[0]['label']);
        },
        legend: {
          display: true,
        },
        responsive: true,
        maintainAspectRatio: false,
      },
    };
  },
  mounted() {
    //renderChart function renders the chart with the datacollection and options object.
    this.renderChart(this.datacollection, this.options);
  },
  created: function () {
    this.getTopFiveInterests();
  },
  computed: {
    ...mapState(interestStore, ['topinterests']),
  },
  watch: {
    topinterests: function () {
      this.makedata();
      this.renderChart(this.datacollection, this.options);
    },
  },
  methods: {
    ...mapActions(interestStore, ['getTopFive']),
    async getTopFiveInterests() {
      await this.getTopFive();
    },
    makedata() {
      this.datacollection.labels = [];
      this.datacollection.data = [];
      console.log('길이: ' + this.topinterests.length);
      for (let i = 0; i < this.topinterests.length; i++) {
        this.datacollection.labels[i] = this.topinterests[i].address;
        this.datacollection.datasets[0].data[i] = this.topinterests[i].count;
      }
    },
  },
};
</script>

<style></style>

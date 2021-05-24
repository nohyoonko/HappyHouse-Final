<script>
//Importing Bar class from the vue-chartjs wrapper
import {Bar} from 'vue-chartjs'
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
            label: 'Data One',
            backgroundColor: '#f87979',
            pointBackgroundColor: 'white',
            borderWidth: 1,
            pointBorderColor: '#249EBF',
            //Data to be represented on y-axis
            data: [40, 20, 30, 50, 90]
          }
        ]
      },
      //Chart.js options that controls the appearance of the chart
      options: {
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            },
            gridLines: {
              display: true
            }
          }],
          xAxes: [ {
            gridLines: {
              display: false
            }
          }]
        },
        legend: {
            display: true
          },
        responsive: true,
        maintainAspectRatio: false
      }
    }
  },
  mounted() {
    //renderChart function renders the chart with the datacollection and options object.
    this.renderChart(this.datacollection, this.options)
  },
  created: function() {
    this.getTopFiveInterests();
  },
  computed:{
    ...mapState(interestStore,['topinterests'])
  },
  methods: {
    ...mapActions(interestStore,['getTopFive']),
    getTopFiveInterests(){
      this.getTopFive();
      console.log(this.topinterests.length);
    }
  },
}
</script>

<style>

</style>
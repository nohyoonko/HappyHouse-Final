<template>
  <article class="row">
			<div id="map" style="width: 100%; height: 500px; margin: auto">
      <GmapMap
		ref="mapRef"
		:center="center"
		:zoom="11"
    style="width:50vw;height:50vh"
		>
    <GmapMarker
      v-for="(m,index) in markers"
      :key="index"
      :position="m.position"
    /> 
      </GmapMap>
    </div>
    </article>
</template>

<script>
export default {
  name:'indexmap',
  // props: {
  //   dong: {type: String},
  // },
  data() {
    return {
      center:{lat : 37.606991, lng : 127.0232185,},
      markers:[
        {
          position:{lat : 37.606991, lng : 127.0232185,},
        },
      ],
    };
  },
  created() {
    
  },
}
</script>

<style>

</style>
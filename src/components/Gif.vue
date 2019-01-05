<template>
  <div class="has-text-centered">
    <div class="gif-container" ref="gifContainer">
    	<div class="gif-overlay" v-if="is_playing == false && is_loaded == true" @click="play()">
    		<div class="gif-text">Gif</div>
    	</div>
    	<div class="gif-image" @click="stop()">
	    	<img :src="src" ref="gif"/>
	    </div>
    </div>
    </div>
</template>
<script>
import SuperGif from 'libgif'
export default {
  name: 'gif',
  data () {
    return {
      is_playing: false,
      is_loaded: false,
      rub: null
    }
  },
  props : {
    src: {
      default: "",
      type: String
    }
  },
  mounted () {
    var self = this
    this.rub = new SuperGif({ gif: this.$refs.gif
                         , auto_play: 0
                         , rubbable: 1
                         , progressbar_background_color: "white"
                         , progressbar_foreground_color: "#a02073" } );
    this.rub.load(function(){
      self.is_playing = false
      self.is_loaded = true
      self.$refs.gifContainer.style.width = self.rub.get_canvas().width + 'px'
      self.$refs.gifContainer.style.height = self.rub.get_canvas().height + 'px'
    });
  },
  methods: {
  	play() {
  		this.rub.play()
  		this.is_playing = true
  	},
  	stop() {
  		this.rub.pause()
  		this.is_playing = false
  	}
  }
}
</script>
<style lang="sass">
.gif-container
  position: relative
  width: 400px
  height: 400px
  margin: auto
  cursor: pointer

.gif-overlay
  background-color:rgba(0, 0, 0, 0.8) !important
  width: 100%
  height: 100%
  margin: auto
  position: absolute
  z-index: 1

.gif-text
  text-transform: uppercase
  color: white
  font-family: Arial, Helvetica, sans-serif
  border-radius: 50%
  width: 100px
  margin: 35% auto
  padding: 30px
  border: 3px white dashed

.gif-image
  position: absolute
  width: 100%
  min-height: 100%
  z-index: 0
</style>
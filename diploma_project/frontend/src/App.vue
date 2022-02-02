<template>
  <div>
    <v-app>
      <Navigation/>
      <v-main>
        <router-view/>
      </v-main>
    </v-app>
  </div>
</template>

<script>
import Navigation from "@/components/Navigation";

export default {
  name: 'App',

  components: {
    Navigation,
  },

  data: () => ({
    //
  }),
};
</script>

<style lang="scss">
.v-select .v-input__control .v-input__slot .v-select__slot .v-select__selections {
  padding: 0 !important;
  min-height: 0 !important;
}

.v-select-list .v-list-item {
  min-height: 0 !important;
}

</style>

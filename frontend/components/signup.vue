<template>
  <div class="signup-wrapper border border-light">
    <h2 class="signup-heading">Create an account</h2>
    <form class="form-signup" @submit.prevent="signup">
      <h3 class="form-heading">Enter your email and password:</h3>
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <label for="inputEmail" class="sr-only">Email address</label>
      <input v-model="email" type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
      <label for="inputPassword" class="sr-only">Password</label>
      <input v-model="password" type="password" id="inputPassword" class="form-control" placeholder="Password" required>
      <label for="confirmPassword" class="sr-only">Confirm Password</label>
      <input v-model="password" type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" required>
      <button class="btn btn-lg btn-primary btn-block" type="submit">Sign up</button>
    </form>
    <p class="signup-question">Already have an account? <router-link to="/login">Sign ip</router-link></p>
  </div>
</template>

<script>
// import { apiUrls } from '../global_variables'
// import { mapGetters } from 'vuex'

// export default {
//   name: 'Signup',
//   data () {
//     return {
//       email: '',
//       password: '',
//       password_confirmation: '',
//       error: false
//     }
//   },

//   created () {
//     this.checkCurrentLogin()
//   },

//   updated () {
//     this.checkCurrentLogin()
//   },

//   computed: {
//       ...mapGetters({ currentUser: 'currentUser' })
//   },

//   methods: {
//     checkCurrentLogin () {
//       if (this.currentUser) {
//         this.$router.replace(this.$route.query.redirect || '/')
//       }
//     },

//     login () {
//       fetch(apiUrls.baseURL + apiUrls.loginURL, {
//             method: "POST",
//             headers: {
//               'Accept': 'application/json',
//               'Content-Type': 'application/json'
//             },
//             body: JSON.stringify({
//               email: this.email,
//               password: this.password
//             })
//       }).then(response => response.json())
//         .then(json => this.requestSucceed(json))
//         .catch(error => this.requestFailed(error));
//     },

//     requestSucceed (jsonResponse) {
//       if (!jsonResponse.auth_token) {
//         this.error = "Your email or password is incorrect"
//         return
//       }
//       localStorage.token = jsonResponse.auth_token
//       this.error = false
//       this.$store.dispatch('login')
//       this.$router.replace(this.$route.query.redirect || '/')
//     },

//     requestFailed (error) {
//       this.error = 'Login failed!'
//       this.$store.dispatch('logout')
//       delete localStorage.token
//     }
//   }
// }
</script>

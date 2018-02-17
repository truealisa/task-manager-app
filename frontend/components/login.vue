<template>
  <div class="login-wrapper border border-light">
    <h2 class="login-heading">Please sign in</h2>
    <form class="form-signin" @submit.prevent="login">
      <h3 class="form-heading">Enter your email and password:</h3>
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <label for="inputEmail" class="sr-only">Email address</label>
      <input v-model="email" type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
      <label for="inputPassword" class="sr-only">Password</label>
      <input v-model="password" type="password" id="inputPassword" class="form-control" placeholder="Password" required>
      <button class="btn btn-login btn-primary btn-block" type="submit">Sign in</button>
    </form>
    <p class="signup-question">Do not have an account? <router-link to="#">Sign up</router-link></p>
  </div>
</template>

<script>
import { apiUrls } from '../global_variables'
import { mapGetters } from 'vuex'

export default {
  name: 'Login',
  data () {
    return {
      email: '',
      password: '',
      error: false
    }
  },

  created () {
    this.checkCurrentLogin()
  },

  updated () {
    this.checkCurrentLogin()
  },

  computed: {
      ...mapGetters({ currentUser: 'currentUser' })
  },

  methods: {
    checkCurrentLogin () {
      if (this.currentUser) {
        this.$router.replace(this.$route.query.redirect || '/')
      }
    },

    login () {
      fetch(apiUrls.baseURL + apiUrls.loginURL, {
            method: "POST",
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              email: this.email,
              password: this.password
            })
      }).then(response => response.json())
        .then(json => this.requestSucceed(json))
        .catch(error => this.requestFailed(error))
    },

    requestSucceed (jsonResponse) {
      if (!jsonResponse.auth_token) {
        this.error = "Your email or password is incorrect"
        return
      }
      localStorage.token = jsonResponse.auth_token
      this.error = false
      this.$store.dispatch('login')
      this.$router.replace(this.$route.query.redirect || '/')
    },

    requestFailed (error) {
      this.error = 'Login failed!'
      this.$store.dispatch('logout')
      delete localStorage.token
    }
  }
}
</script>

<style lang="css">
.login-wrapper {
  background: #fff;
  max-width: 500px;
  margin: 4% auto;
  animation: fadein 0.6s;
  border-bottom-right-radius: 20px;
  border-bottom-left-radius: 20px;
}

@keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

.login-heading {
  display: block;
  width: 100%;
  padding-top: 10px;
  background: linear-gradient(#4A80B8, #35619E);
  text-align: center;
  font-size: 24px;
  color: #fff;
  text-shadow: 0px 1px 0px #555;
  border-radius: 2px;
  border-top-color: #8AAFD4;
  box-shadow: 0px -1px 0px 0px #8AAFD4,
              0px -1px 0px 1px #35619E;

  margin-bottom: 25px;
  padding-bottom: 10px;
}

.form-signin {
  max-width: 330px;
  padding: 0 15px 10px 15px;
  margin: 0 auto;
  position: relative;
}

.form-signin .form-heading {
  font-size: 18px;
  color: #333;
  padding: 0;
  margin-bottom: 15px;
}

.form-signin .form-control {
  position: relative;
  height: auto;
  -webkit-box-sizing: border-box;
          box-sizing: border-box;
  padding: 10px;
  font-size: 16px;
}
.form-signin .form-control:focus {
  z-index: 2;
}
.form-signin input[type="email"] {
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}
.form-signin input[type="password"] {
  border-top-right-radius: 0;
  border-top-left-radius: 0;
  margin-bottom: 30px;
}

.signup-question {
  color: #666;
  font-size: 14px;
  padding: 0;
  margin: 0;
  text-align: center;
  margin-bottom: 25px;
}

.form-signin .alert {
  position: absolute;
  top: -13px;
  left: 15px;
  width: 91%;
  z-index: 999;
  animation: fadein 0.6s;
}
</style>

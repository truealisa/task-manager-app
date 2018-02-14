<template>
  <div class="login-wrapper border border-light">
    <form class="form-signin" @submit.prevent="login">
      <h2 class="form-signin-heading">Please sign in</h2>
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <label for="inputEmail" class="sr-only">Email address</label>
      <input v-model="email" type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
      <label for="inputPassword" class="sr-only">Password</label>
      <input v-model="password" type="password" id="inputPassword" class="form-control" placeholder="Password" required>
      <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    </form>
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
        this.$router.replace(this.$route.query.redirect || '/projects')
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
        .catch(error => this.requestFailed(error));
    },

    requestSucceed (jsonResponse) {
      if (!jsonResponse.auth_token) {
        this.error = jsonResponse.message
        return
      }
      localStorage.token = jsonResponse.auth_token
      this.error = false
      this.$store.dispatch('login')
      this.$router.replace(this.$route.query.redirect || '/projects')
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
body {
  background-color: #605B56;
}

.login-wrapper {
  background: #fff;
  width: 70%;
  margin: 12% auto;
  animation: fadein 0.6s;
}

@keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

.form-signin {
  max-width: 330px;
  padding: 10% 15px;
  margin: 0 auto;
}
.form-signin .form-signin-heading,
.form-signin .checkbox {
  margin-bottom: 10px;
}
.form-signin .checkbox {
  font-weight: normal;
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
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}
.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
</style>

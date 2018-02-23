<template>
  <div class="signup-wrapper border border-light">
    <h2 class="signup-heading">Create an account</h2>
    <form class="form-signup" @submit.prevent="signup">
      <h3 class="form-heading">Enter your name, email and password:</h3>
      <div class="alert alert-danger" v-if="error" v-html="error"></div>
      <label for="inputName" class="sr-only">Name</label>
      <input v-model="name" type="name" id="inputName" class="form-control" placeholder="Name" required autofocus>
      <label for="inputEmail" class="sr-only">Email address</label>
      <input v-model="email" type="email" id="inputEmail" class="form-control" placeholder="Email address" required>
      <label for="inputPassword" class="sr-only">Password</label>
      <input v-model="password" ref="password" type="password" id="inputPassword" class="form-control" placeholder="Password" required>
      <label for="confirmPassword" class="sr-only">Confirm Password</label>
      <input v-model="password_confirmation" ref="passwordConfirmation" type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" required>
      <button class="btn btn-signup btn-primary btn-block" type="submit">Sign up</button>
    </form>
    <p class="signup-question">Already have an account? <router-link to="/login">Login</router-link></p>
  </div>
</template>

<script>
import { apiUrls } from '../global_variables'
import { mapGetters } from 'vuex'

export default {
  name: 'Signup',
  data () {
    return {
      name: '',
      email: '',
      password: '',
      password_confirmation: '',
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

    signup () {
      fetch(apiUrls.baseURL + apiUrls.signupURL, {
            method: "POST",
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              name: this.name,
              email: this.email,
              password: this.password,
              password_confirmation: this.password_confirmation
            })
      }).then(response => response.json())
        .then(json => this.requestSucceed(json))
        .catch(error => this.requestFailed(error));
    },

    requestSucceed (jsonResponse) {
      if (!jsonResponse.auth_token) {
        this.error = jsonResponse.message.replace(/,/g,'<br>• ').replace(/:/g,':<br>• ')
        return
      }
      localStorage.token = jsonResponse.auth_token
      this.error = false
      this.$store.dispatch('login')
      this.$router.replace(this.$route.query.redirect || '/')
    },

    requestFailed (error) {
      this.error = error
    }
  }
}
</script>

<style>
  .signup-wrapper {
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

  .signup-heading {
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

  .form-signup {
    max-width: 330px;
    padding: 0 15px 10px 15px;
    margin: 0 auto;
    position: relative;
  }

  .form-signup .form-heading {
    font-size: 18px;
    color: #333;
    padding: 0;
    margin-bottom: 15px;
  }

  .form-signup .form-control {
    position: relative;
    height: auto;
    -webkit-box-sizing: border-box;
            box-sizing: border-box;
    padding: 10px;
    font-size: 16px;
  }
  .form-signup .form-control:focus {
    z-index: 2;
  }
  .form-signup input:not(:last-of-type) {
    border-bottom-right-radius: 0;
    border-bottom-left-radius: 0;
  }

  .form-signup input:not(:first-of-type) {
    border-top-right-radius: 0;
    border-top-left-radius: 0;
  }

  .form-signup input:last-of-type {
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

  .form-signup .alert {
    animation: fadein 0.6s;
  }
</style>

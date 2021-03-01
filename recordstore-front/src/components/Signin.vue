<template>
    <div>
        <div>
            <h3>Sign In</h3>
            <form @submit.prevent="signin">
                <div v-if="error">{{error}}</div>

                <div>
                    <label for="email">E-mail Address</label>
                    <input type="email" v-model="email" id="email">
                </div>

                <div>
                    <label for="password">Password</label>
                    <input type="password" v-model="password" id="password">
                </div>

                <button type="submit">submit</button>

                <div>
                    <router-link to="/signup" >Sign Up</router-link>
                </div>

            </form>
        </div>
    </div>
</template>

<script>
export default({
    name: 'Signin',
    data() {
        return {
            email: '',
            password: '',
            error: ''
        }
    },
    created(){
        this.checkedSignedIn()
    },  
    updated(){
        this.checkedSignedIn()
    },
    methods: {
        signin(){
            this.$http.plain.post('/signin', {email: this.email, password: this.password})
            .then(response => this.signinSuccessful(response))
            .catch(error => this.signinFailed(error))
        },
        signinSuccessful(response){
            if(!response.data.csrf){
                this.signinFailed(response)
                return
            }
            localStorage.csrf = response.data.csrf
            localStorage.signedIn = true
            this.error = ''
            this.$router.replace('/records')
        },
        signinFailed(error){
            this.error = (error.response && error.response.data && error.response.data.error) || ''
            delete localStorage.csrf
            delete localStorage.signedIn
        },
        checkedSignedIn(){
            if(localStorage.signedIn){
                this.$router.replace('/records')
            }
        }
    }
})
</script>
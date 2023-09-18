import Head from 'next/head'
import Image from 'next/image'
import { Inter } from '@next/font/google'
import styles from '@/styles/Home.module.css'
import LoginPage from 'pages/login.js'
import axios from 'axios'

const inter = Inter({ subsets: ['latin'] })
axios.defaults.withCredentials = true
axios.defaults.xsrfHeaderName = "X-CSRFTOKEN";
axios.defaults.xsrfCookieName = "csrftoken";
export default function Home() {
  return (
    <div className="login-container">
      <LoginPage />
    </div>
  )
}

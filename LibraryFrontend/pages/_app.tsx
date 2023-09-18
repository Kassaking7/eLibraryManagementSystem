import '@/styles/globals.css'
import "../styles/index.css";
import "../styles/mainPage.css";
import "../styles/information.css";
import type { AppProps } from 'next/app'
import axios from 'axios'
axios.defaults.withCredentials = true
//axios.defaults.xsrfHeaderName = "X-CSRFTOKEN";
//axios.defaults.xsrfCookieName = "csrftoken";
export default function App({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />
}

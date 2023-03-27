import '@/styles/globals.css'
import "../styles/index.css";
import "../styles/mainPage.css";
import "../styles/information.css";
import type { AppProps } from 'next/app'

export default function App({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />
}

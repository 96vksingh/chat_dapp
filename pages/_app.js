import { NavBar } from '@/compoments';
import { ChatAppProvider } from '@/Context/ChatAppContext';
import '@/styles/globals.css'

// export default function App  ({ Component, pageProps }) {
//   return <Component {...pageProps} />
// }

// internal iports
// import { CheckifWalletisconnected, connectingWithContract, connectWallet } from '@/utils/apiFeature';



const App = ({ Component, pageProps }) => {
  return<div>
    <ChatAppProvider>
      <NavBar />
    <Component {...pageProps} />
    </ChatAppProvider>
  </div> 
}

export default App;
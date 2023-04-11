import { useRouter } from 'next/router';
import React,{useState,useEffect} from 'react';

// internal imports

import { CheckifWalletisconnected, connectingWithContract, connectWallet } from '@/utils/apiFeature';


export const ChatAppContext = React.createContext();

export const ChatAppProvider = ({children}) => {
    const title = "Hey welcome to blockchain chatapp";

    return <ChatAppContext.Provider value={{title}}>
        {children}
    </ChatAppContext.Provider>

}

// import Style from './ChatAppContext.module.css';
// const ChatAppContext = () => {
//     return <div>

//     </div>
// }

// export default ChatAppContext;
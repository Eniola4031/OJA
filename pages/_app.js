import '../styles/globals.css'
import Link from 'next/link'

function ojaMarketplace({Component, pageProps}){
  return(
    <div>
      <nav className='border-b p-6' style={{backgroundColor:'white'}}>
        <p className='text-4x1 font-bold text-black'> OJA AFRICAN NFT MARKETPLACE
        </p>
        <div className='flex mt-4 justify-center'>
          <Link href='/'>
            <a className='mr-4'> Main MarketPlace</a>
          </Link>
          <Link href='/'>
            <a className='mr-4'> Main MarketPlace</a>
          </Link>
           <Link href='/'>
            <a className='mr-4'> Main MarketPlace</a>
          </Link> 
          <Link href='/'>
            <a className='mr-4'> Main MarketPlace</a>
          </Link>
        </div>
      </nav>
    </div>
    
  )
}

import React, { useEffect, useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import Navbar from '../Components/Navbar'
import { TEXT } from '../../constants/text'
import { getMessages, isLoggedIn, saveMessages } from '../../utils/foodData'

const DEFAULT_THREADS = [
  {
    id: 'support',
    name: 'FoodHub Support',
    role: 'Chăm sóc khách hàng',
    messages: [
      { from: 'them', text: 'FoodHub có thể hỗ trợ gì cho bạn?', time: new Date().toISOString() },
    ],
  },
]

function MessagesPage() {
  const navigate = useNavigate()
  const [threads, setThreads] = useState([])
  const [activeId, setActiveId] = useState('support')
  const [message, setMessage] = useState('')

  useEffect(() => {
    if (!isLoggedIn()) {
      navigate('/login', { state: { from: '/messages' } })
      return
    }
    const stored = getMessages().filter((thread) => thread.id !== 'shipper')
    const next = stored.length ? stored : DEFAULT_THREADS
    setThreads(next)
    if (!stored.length) saveMessages(next)
  }, [navigate])

  useEffect(() => {
    if (!isLoggedIn()) return undefined
    const syncMessages = () => {
      const stored = getMessages()
      const next = stored.filter((thread) => thread.id !== 'shipper')
      if (next.length) setThreads(next)
    }
    const timer = setInterval(syncMessages, 1200)
    window.addEventListener('storage', syncMessages)
    window.addEventListener('foodhub-storage-sync', syncMessages)
    return () => {
      clearInterval(timer)
      window.removeEventListener('storage', syncMessages)
      window.removeEventListener('foodhub-storage-sync', syncMessages)
    }
  }, [])

  const activeThread = useMemo(() => threads.find((thread) => thread.id === activeId) || threads[0], [threads, activeId])

  const persist = (next) => {
    setThreads(next)
    saveMessages(next)
  }

  const sendMessage = (e) => {
    e.preventDefault()
    if (!message.trim() || !activeThread) return
    const next = threads.map((thread) => {
      if (thread.id !== activeThread.id) return thread
      return {
        ...thread,
        messages: [
          ...thread.messages,
          { from: 'me', text: message.trim(), time: new Date().toISOString(), sender: 'user' },
        ],
      }
    })
    persist(next)
    setMessage('')
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar />
      <main className="mx-auto w-full max-w-7xl px-4 py-8 sm:px-6 sm:py-10 lg:px-8">
        <h1 className="text-2xl font-extrabold text-gray-900 sm:text-3xl">{TEXT.page_messages_title}</h1>
        <div className="mt-6 grid min-w-0 grid-cols-1 gap-4 lg:mt-8 lg:grid-cols-[320px_minmax(0,1fr)] lg:gap-6">
          <aside className="bg-white border border-gray-100 rounded-2xl shadow-sm overflow-hidden">
            {threads.map((thread) => (
              <button
                key={thread.id}
                onClick={() => setActiveId(thread.id)}
                className={`w-full text-left px-5 py-4 border-b border-gray-100 hover:bg-orange-50 ${activeThread?.id === thread.id ? 'bg-orange-50' : ''}`}
              >
                <p className="font-bold text-gray-900">{thread.name}</p>
                <p className="text-sm text-gray-500">{thread.role}</p>
                <p className="text-xs text-gray-400 mt-2 line-clamp-1">{thread.messages[thread.messages.length - 1]?.text}</p>
              </button>
            ))}
          </aside>

          <section className="flex min-h-[60dvh] min-w-0 flex-col overflow-hidden rounded-2xl border border-gray-100 bg-white shadow-sm lg:min-h-[520px]">
            {activeThread ? (
              <>
                <div className="px-5 py-4 border-b border-gray-100">
                  <h2 className="font-bold text-gray-900">{activeThread.name}</h2>
                  <p className="text-sm text-gray-500">{activeThread.role}</p>
                </div>
                <div className="flex-1 space-y-3 overflow-y-auto bg-gray-50 p-3 sm:p-5">
                  {activeThread.messages.map((item, index) => (
                    <div key={index} className={`flex ${item.from === 'me' ? 'justify-end' : 'justify-start'}`}>
                      <div className={`max-w-[88%] break-words rounded-2xl px-4 py-3 text-sm sm:max-w-[75%] ${item.from === 'me' ? 'bg-orange-500 text-white' : 'bg-white text-gray-700 border border-gray-100'}`}>
                        {item.text}
                      </div>
                    </div>
                  ))}
                </div>
                <form onSubmit={sendMessage} className="p-4 border-t border-gray-100 flex gap-3">
                  <input
                    value={message}
                    onChange={(e) => setMessage(e.target.value)}
                    placeholder="Nhập tin nhắn..."
                    className="flex-1 rounded-xl border border-gray-200 px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-orange-400"
                  />
                  <button className="rounded-xl bg-orange-500 px-5 py-3 text-sm font-bold text-white hover:bg-orange-600">Gửi</button>
                </form>
              </>
            ) : (
              <div className="p-10 text-gray-500">{TEXT.page_messages_empty}</div>
            )}
          </section>
        </div>
      </main>
    </div>
  )
}

export default MessagesPage

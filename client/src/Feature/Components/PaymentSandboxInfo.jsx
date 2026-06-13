import { useState } from 'react'

function PaymentSandboxInfo({ method }) {
  const [open, setOpen] = useState(false)
  if (!['vnpay', 'zalopay'].includes(method)) return null

  return (
    <div className="rounded-2xl border border-gray-200 dark:border-slate-700">
      <button type="button" aria-expanded={open} onClick={() => setOpen(!open)}
        className="flex min-h-11 w-full items-center justify-between px-4 text-sm font-bold">
        <span>Thông tin thẻ test (Sandbox)</span><span>{open ? '−' : '+'}</span>
      </button>
      {open && method === 'vnpay' && (
        <div className="border-t border-gray-200 p-4 text-sm leading-6 dark:border-slate-700">
          <p className="font-black">Thẻ ATM NCB</p>
          <p>Số thẻ: 9704198526191432198</p><p>Tên: NGUYEN VAN A</p>
          <p>Ngày: 07/15</p><p>OTP: 123456</p>
        </div>
      )}
      {open && method === 'zalopay' && (
        <div className="border-t border-gray-200 p-4 text-sm leading-6 dark:border-slate-700">
          <p className="font-black">Visa Sandbox</p>
          <p>Số thẻ: 4111111111111111</p><p>CVV: 123</p><p>Hết hạn: 12/25</p>
        </div>
      )}
    </div>
  )
}

export default PaymentSandboxInfo

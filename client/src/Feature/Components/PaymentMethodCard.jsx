function PaymentMethodCard({ value, selected, title, description, badge, disabled, onSelect }) {
  return (
    <button
      type="button"
      disabled={disabled}
      aria-pressed={selected}
      onClick={() => onSelect(value)}
      className={`flex min-h-20 w-full items-center gap-3 rounded-2xl border p-3 text-left transition ${
        selected
          ? 'border-orange-500 bg-orange-50 ring-2 ring-orange-200 dark:bg-orange-950/30'
          : 'border-gray-200 bg-white hover:border-orange-300 dark:border-slate-700 dark:bg-slate-900'
      } disabled:cursor-not-allowed disabled:opacity-45`}
    >
      <span className="grid h-12 w-12 shrink-0 place-items-center rounded-xl bg-gradient-to-br from-orange-400 to-red-500 text-xs font-black text-white">
        {badge}
      </span>
      <span className="min-w-0 flex-1">
        <span className="block font-black text-gray-900 dark:text-white">{title}</span>
        <span className="mt-0.5 block text-xs text-gray-500 dark:text-slate-400">{description}</span>
      </span>
      <span className={`grid h-6 w-6 place-items-center rounded-full border ${selected ? 'border-orange-500 bg-orange-500 text-white' : 'border-gray-300'}`}>
        {selected ? '✓' : ''}
      </span>
    </button>
  )
}

export default PaymentMethodCard

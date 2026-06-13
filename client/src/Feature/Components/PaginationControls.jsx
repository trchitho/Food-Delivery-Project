import { ChevronLeftIcon, ChevronRightIcon } from '@heroicons/react/24/outline'

function PaginationControls({ page, totalPages, onPageChange }) {
  if (totalPages <= 1) return null
  const buttonClass = 'inline-flex h-11 min-w-11 items-center justify-center rounded-xl border border-gray-200 bg-white px-3 text-gray-700 transition hover:border-orange-300 disabled:opacity-40 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200'

  return (
    <nav aria-label="Phân trang nhà hàng" className="mt-8 flex items-center justify-center gap-3">
      <button type="button" aria-label="Trang trước" disabled={page === 1}
        onClick={() => onPageChange(page - 1)} className={buttonClass}>
        <ChevronLeftIcon className="h-5 w-5" />
      </button>
      <span className="min-w-16 text-center text-sm font-bold text-gray-700 dark:text-slate-200">
        {page} / {totalPages}
      </span>
      <button type="button" aria-label="Trang sau" disabled={page === totalPages}
        onClick={() => onPageChange(page + 1)} className={buttonClass}>
        <ChevronRightIcon className="h-5 w-5" />
      </button>
    </nav>
  )
}

export default PaginationControls

function RatingStars({ value = 0, onChange, readonly = false }) {
  return (
    <div className="flex items-center gap-1" aria-label={`${value} trên 5 sao`}>
      {[1, 2, 3, 4, 5].map((star) => readonly ? (
        <span key={star} className={star <= value ? 'text-amber-400' : 'text-gray-300'}>★</span>
      ) : (
        <button
          key={star}
          type="button"
          aria-label={`Chọn ${star} sao`}
          onClick={() => onChange(star)}
          className={`h-11 w-9 text-2xl transition ${star <= value ? 'text-amber-400' : 'text-gray-300 hover:text-amber-300'}`}
        >
          ★
        </button>
      ))}
    </div>
  )
}

export default RatingStars

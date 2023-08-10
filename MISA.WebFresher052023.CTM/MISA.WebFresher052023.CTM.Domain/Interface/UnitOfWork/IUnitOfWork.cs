using System.Data.Common;

namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Quản lý connection, transaction của db
    /// </summary>
    /// CreatedBy: TTANH (18/07/2023)
    public interface IUnitOfWork : IDisposable, IAsyncDisposable
    {
        #region Fields
        DbConnection Connection { get; }
        DbTransaction? Transaction { get; }
        #endregion

        #region Methods
        /// <summary>
        /// Bắt đầu transaction
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        void BeginTransaction();

        /// <summary>
        /// Bắt đầu transaction bất đồng bộ
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        Task BeginTransactionAsync();

        /// <summary>
        /// Xác nhận transaction
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        void Commit();

        /// <summary>
        /// Xác nhận transaction bất đồng bộ
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        Task CommitAsync();

        /// <summary>
        /// Quay trở lại từ điểm bắt đầu transaction
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        void Rollback();

        /// <summary>
        /// Quay trở lại từ điểm bắt đầu transaction bất đồng bộ
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        Task RollbackAsync();
        #endregion
    }
}

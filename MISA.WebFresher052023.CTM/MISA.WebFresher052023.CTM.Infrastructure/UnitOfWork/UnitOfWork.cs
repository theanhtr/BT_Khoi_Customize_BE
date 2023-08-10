using MISA.WebFresher052023.CTM.Domain;
using MySqlConnector;
using System.Data;
using System.Data.Common;

namespace MISA.WebFresher052023.CTM.Infrastructure
{
    public sealed class UnitOfWork : IUnitOfWork
    {
        #region Fields
        private readonly DbConnection _connection;
        private DbTransaction? _transaction = null;
        #endregion

        #region Constructor
        public UnitOfWork(string connectionString)
        {
            _connection = new MySqlConnection(connectionString);
        }
        #endregion

        #region Methods
        /// <summary>
        /// Lấy giá trị Connection
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public DbConnection Connection => _connection;

        /// <summary>
        /// Lấy giá trị Transaction
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public DbTransaction? Transaction => _transaction;

        /// <summary>
        /// Bắt đầu transaction
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public void BeginTransaction()
        {
            if (_connection.State != ConnectionState.Open)
            {
                _connection.Open();
            }

            _transaction = _connection.BeginTransaction();
        }

        /// <summary>
        /// Bắt đầu transaction bất đồng bộ
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public async Task BeginTransactionAsync()
        {
            if (_connection.State != ConnectionState.Open)
            {
                await _connection.OpenAsync();
            }

            _transaction = await _connection.BeginTransactionAsync();
        }

        /// <summary>
        /// Xác nhận transaction
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public void Commit()
        {
            _transaction?.Commit();
            Dispose();
        }

        /// <summary>
        /// Xác nhận transaction bất đồng bộ
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public async Task CommitAsync()
        {
            if (_transaction != null)
            {
                await _transaction.CommitAsync();
            }
            await DisposeAsync();
        }

        /// <summary>
        /// Giải phóng transaction và đóng connection
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public void Dispose()
        {
            _transaction?.Dispose();
            _transaction = null;
            
            if (_connection.State != ConnectionState.Closed)
            {
                _connection.Close();
            }
        }

        /// <summary>
        /// Giải phóng transaction và đóng connection bất đồng bộ
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public async ValueTask DisposeAsync()
        {
            if (_transaction != null)
            {
                await _transaction.DisposeAsync();
                _transaction = null;
            }

            if (_connection.State == ConnectionState.Closed)
            {
                await _connection.CloseAsync();
            }
        }

        /// <summary>
        /// Quay trở lại từ điểm bắt đầu transaction
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public void Rollback()
        {
            _transaction?.Rollback();
            Dispose();
        }

        /// <summary>
        /// Quay trở lại từ điểm bắt đầu transaction bất đồng bộ
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public async Task RollbackAsync()
        {
            if (_transaction != null )
            {
                await _transaction.RollbackAsync();
            }
            await DisposeAsync();
        }
        #endregion
    }
}

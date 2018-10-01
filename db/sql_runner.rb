require('pg')
require_relative('../models/customers')
require_relative('../models/films')
require_relative('../models/tickets')

class SqlRunner

  def self.run(sql, values = [])
    db = PG.connect({ # connects to db
      dbname: 'codeclan_cinema', #db name
      host: 'localhost' #db location
    })
    db.prepare('query', sql)

    results = db.exec_prepared('query', values)

    db.close()
    return results
  end

end

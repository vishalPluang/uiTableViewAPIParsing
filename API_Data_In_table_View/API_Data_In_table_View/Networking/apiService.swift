import Foundation

struct ApiService
{
    func getPopularMoviesData(completionHandler: @escaping(Result<MovieData, Error>) -> Void)
    {
        let MovieApiUrl = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        let apiUrl = URL(string: MovieApiUrl)!
        
        URLSession.shared.dataTask(with: apiUrl){(data, response, error) in
            
            if let error = error {
                completionHandler(.failure(error))
                print("error : \(error.localizedDescription)")
                return
            }
            
            guard let response = response else {
                return
            }
            
            print("response = \(response)")
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do
            {
                let jsonData = try JSONDecoder().decode(MovieData.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(jsonData))
                }
            }
            catch let error
            {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}

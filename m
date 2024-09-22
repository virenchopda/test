Stack(
        children: [
          SizedBox(
            height: 300,
            width: 500,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, i) {
                return Image.network(
                  "https://cdn.pixabay.com/photo/2024/08/23/12/53/water-lily-8991682_960_720.png",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          IgnorePointer(
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

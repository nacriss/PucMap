Widget build(BuildContext context) {
  return Scaffold(
    
    body: Column(
      children: [
        // BARRA DE PESQUISA 
        Container(
          color: Color(0xFF2BA6A0),
          padding: EdgeInsets.only(top: 40, left: 12, right: 12, bottom: 12),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(Icons.menu, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Hinted search text",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.search, color: Colors.white),
              ],
            ),
          ),
        ),

        
        Expanded(child: _telas[_indiceAtual]),
      ],
    ),

    // BOTTOM NAVIGATION 
    bottomNavigationBar: Container(
      decoration: BoxDecoration(
        color: Color(0xFF2BA6A0),
      ),
      child: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: onTabTapped,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF2BA6A0),
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        elevation: 0,
        items: [
          _buildNavItem(Icons.place, "Explore", 0),
          _buildNavItem(Icons.apartment, "Prédios", 1),
          _buildNavItem(Icons.event, "Eventos", 2),
          _buildNavItem(Icons.person, "Perfil", 3),
        ],
      ),
    ),
  );
}
